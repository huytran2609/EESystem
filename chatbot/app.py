import uuid
from pathlib import Path
from flask import Flask, render_template, request, jsonify
from flask_cors import CORS
from pydantic import BaseModel
# from fastapi import status
from langchain_core.documents import Document
from langchain_core.messages import HumanMessage, SystemMessage
from langchain_core.prompts import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate
from langchain.chains import LLMChain
from langchain_openai import OpenAI, ChatOpenAI, OpenAIEmbeddings
from langchain_community.vectorstores.faiss import FAISS
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_community.document_loaders.text import TextLoader
from langchain_pinecone import PineconeVectorStore
from openai import OpenAI as OpenAIClient
from pinecone import Pinecone
import os
from chat import get_response
# from typing import List

app = Flask(__name__, template_folder='../chatbot.php')
CORS(app)

# Khởi tạo FastAPI cho các loại dữ liệu
class AddText(BaseModel):
    text: str

class InputQuestion(BaseModel):
    question: str
    mode: str = 'medium'

class ParamsOpenAI(BaseModel):
    temperature: float = 0.7
    max_tokens: int = 800
    top_p: float = 0.95
    frequency_penalty: float = 0
    presence_penalty: float = 0
    stop_sequences: list | None = None
    system_content: str | None = None

# SYSTEM_MESSAGE_PROMPT_TEMPLATE = """Sử dụng các đoạn ngữ cảnh sau để trả lời câu hỏi của người dùng.
# Một số quy tắc khi trả lời câu hỏi:
# 1. Ngôn ngữ Việt Nam được ưu tiên.
# 2. Bạn nên trả lời "Tôi không biết" khi bạn không thấy câu trả lời, không cố gắng tạo ra câu trả lời.
# 3. Không suy diễn câu trả lời, chỉ trả lời câu hỏi dựa trên ngữ cảnh.
# 4. Trả lời câu hỏi trong vòng dưới 150 từ.
# 5. Không đề cập đến câu hỏi trong câu trả lời.
# 6. Trả lời câu hỏi bằng cùng ngôn ngữ mà câu hỏi được đặt ra.
# 7. Câu trả lời của bạn nên được định dạng dưới dạng markdown mà không cần ghi nhận định dạng.
# 8. Chỉ trả lời trong phạm vi kiến thức dưới đây.
# ----------------
# {context}"""

SYSTEM_MESSAGE_PROMPT_TEMPLATE = """Sử dụng các đoạn ngữ cảnh sau để trả lời câu hỏi của người dùng.
Một số quy tắc khi trả lời câu hỏi:
1. Ngôn ngữ Việt Nam được ưu tiên.
2. Bạn nên trả lời "Kiến thức này không nằm trong phạm vi của tôi" khi bạn không thấy từ ngữ nào liên quan đến ngữ cảnh trong câu hỏi, không cố gắng tạo ra câu trả lời.
3. Chỉ trả lời suy luận dựa trên ngữ cảnh bên dưới.
4. Trả lời câu hỏi trong vòng dưới 150 từ.
5. Không đề cập đến câu hỏi trong câu trả lời.
6. Trả lời câu hỏi bằng cùng ngôn ngữ mà câu hỏi được đặt ra.
7. Câu trả lời của bạn nên được định dạng dưới dạng markdown mà không cần ghi nhận định dạng và câu trả lời không có các tiền tố đầu tiên như "Bot:", "Machine:", "System:".
8. Chỉ trả lời trong phạm vi kiến thức dưới đây.
----------------
{context}"""

# Thiết lập môi trường

os.environ["OPENAI_API_KEY"] = ""
os.environ["OPENAI_ORGANIZATION"] = ""
os.environ["PINECONE_API_KEY"] = ""

pc = Pinecone(api_key="")
# Khởi tạo Pinecone và các thành phần Langchain
index = pc.Index("vectordb")

llm = OpenAI()
chat = ChatOpenAI(temperature=0.1)
embeddings = OpenAIEmbeddings(model="text-embedding-3-small", openai_api_key="")

@app.route('/')
def home():
    return render_template('chatbot.html')

@app.route('/get_response', methods=['POST'])
def handle_response():
    user_message = request.json['user_message']
    namespace = request.json.get('namespace', 'cosodulieu')
    response = get_response(user_message, namespace)
    print(response)
    return response

@app.route('/add_text', methods=['POST'])
def add_text():
    data = request.get_json()
    add_text_model = AddText(**data)
    id = uuid.uuid4().hex
    docs = [Document(page_content=add_text_model.text, metadata={'id': id, 'source': 'Data custom'}, ids=id)]
    PineconeVectorStore.from_documents(docs, embeddings, index_name="vectordb", ids=[id])
    return jsonify({"status": "success"})

@app.route('/add_data', methods=['GET'])
def add_data():
    db = PineconeVectorStore.from_existing_index(index_name="vectordb", embedding=embeddings)
    text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=0, separators=[" ", ",", "\n"])
    loader = TextLoader(file_path="./cosodulieu/whole_text_chuanhoaldqh.txt", encoding='utf8')
    documents = loader.load()
    docs = text_splitter.split_documents(documents)
    db.add_documents(documents=docs, namespace="cosodulieu")
    return jsonify({"message": "Successfully!"})

@app.route('/init_data', methods=['GET'])
def init_data():
    db = PineconeVectorStore.from_existing_index(index_name="vectordb", embedding=embeddings, namespace="cosodulieu")
    db.delete(delete_all=True)
    # text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=0, separators=[" ", ",", "\n"])
    # loader = TextLoader(file_path="./whole_text/whole_text_dayso.txt", encoding='utf8')
    # documents = loader.load()
    # docs = text_splitter.split_documents(documents)
    # PineconeVectorStore.from_documents(docs, embeddings, index_name="vectordb")
    return jsonify({"message": "Succesfully"})

# @app.route('/get_namespace', methods=['GET'])
def compare_namespaces(question: str):
    # question = request.args.get('question')
    max_similarity = -1
    best_namespace = ""
    namespaces = index.describe_index_stats()['namespaces'].keys()
    print(namespaces)

    for namespace in namespaces:
        # Initialize PineconeVectorStore for each namespace

        # Search for similar documents in the namespace
        search_results = PineconeVectorStore(index_name="vectordb", embedding=embeddings, namespace=namespace).similarity_search_with_score(question, k=1)

        # Get the similarity score
        similarity_score = search_results[0][1] if search_results else 0
        print(similarity_score)

        # Compare similarity scores and update the best namespace
        if similarity_score > max_similarity:
            max_similarity = similarity_score
            best_namespace = namespace
        print(max_similarity)
    return best_namespace

def remove_prefix(text, prefixes):
    for prefix in prefixes:
        if text.startswith(prefix):
            print(f"Removing prefix: {prefix}")
            text = text[len(prefix):]
    return text


@app.route('/answer', methods=['POST'])
def chat_fun():
    data = request.get_json()
    input_data = InputQuestion(**data)
    documents = []
    best_namespace = ""

    if input_data.mode == 'medium':
        system_template = SYSTEM_MESSAGE_PROMPT_TEMPLATE
        messages = [
            SystemMessagePromptTemplate.from_template(system_template),
            HumanMessagePromptTemplate.from_template("{question}"),
        ]
        prompt = ChatPromptTemplate.from_messages(messages)
         # Compare namespaces based on input question
        if 'namespace' in data:
            best_namespace = data['namespace']
        else:
            best_namespace = compare_namespaces(input_data.question)
        print(best_namespace)
        data_search = PineconeVectorStore(index_name="vectordb", embedding=embeddings, namespace=best_namespace).similarity_search_with_score(input_data.question, k=4)
        context = ''
        len_list = len(data_search)
        index = 0
        for item in data_search:
            document = item[0]
            score = item[1]
            context += document.page_content
            if index < len_list - 1:
                context += "\n"
        chains = LLMChain(llm=OpenAI(temperature=0.1, max_tokens=900), prompt=prompt, verbose=True)
        data = chains.run({"context": context, "question": input_data.question})
        answer = data
    else:
        messages = [
            SystemMessage(content="You are a powerful assistant specializing in communication and answering questions."),
            HumanMessage(content=input_data.question),
        ]
        data = chat.invoke(messages)
        answer = data.content
    print(answer)
    answer = remove_prefix(answer, ["Machine:", "System:", "Bot:"])
    print("sau khi xử lí: ", answer)
    response_data = {
        "question": input_data.question,
        "answer": answer if answer != "" else "không thể trả lời",
        "namespace": best_namespace,
        "documents": documents,
    }
    return jsonify({
        'status': 1,
        'msg': "success",
        'data': response_data,
        'errors': []
    })

if __name__ == '__main__':
    app.run(debug=True)
    
    
    




# from flask import Flask, render_template, request
# from flask_cors import CORS
# from chat import get_response

# # app = Flask(__name__)
# app = Flask(__name__, template_folder='design')
# CORS(app)

# @app.route('/')
# def home():
#     return render_template('chatbot.html')

# @app.route('/get_response', methods=['POST'])
# def handle_response():  # Đổi tên hàm xử lý route thành handle_response
#     user_message = request.json['user_message']  # Sử dụng request.json để trích xuất dữ liệu
#     response = get_response(user_message)
#     print(response)
#     return response

# if __name__ == '__main__':
#     app.run(debug=True)





# import streamlit as st
# from chat import get_response

# # Đặt tiêu đề mới cho ứng dụng Streamlit
# st.set_page_config(page_title="Chatbot")
# st.title("🤖")

# # Khởi tạo lịch sử tin nhắn
# if "messages" not in st.session_state:
#     st.session_state.messages = []

# # Hiển thị tin nhắn từ lịch sử khi ứng dụng chạy lại
# for message in st.session_state.messages:
#     if message["role"] == "user":
#         with st.chat_message("user"):
#             st.markdown(message["content"])
#     else:
#         if "image" in message:
#             with st.expander("Image"):
#                 st.image(message["image"], use_column_width=True)
#         else:
#             with st.chat_message("assistant"):
#                 st.markdown(message["content"])

# # Nhận input từ người dùng
# user_message = st.chat_input("Nhập tin nhắn của bạn:")
# if user_message:
#     # Hiển thị tin nhắn của người dùng
#     st.chat_message("user").markdown(user_message)
#     # Thêm tin nhắn của người dùng vào lịch sử tin nhắn
#     st.session_state.messages.append({"role": "user", "content": user_message})

#     # Lấy phản hồi từ chatbot
#     response = get_response(user_message)
#     # print(response)

#     # Hiển thị phản hồi của chatbot
#     if "image" in response and response["image"]:
#         with st.expander("Image"):
#             st.image(response["image"], use_column_width=True)
#     if "text" in response:  # Kiểm tra xem thuộc tính text có tồn tại trong response hay không
#         st.chat_message("assistant").markdown(response["text"])
#     else:
#         st.chat_message("assistant").markdown(response)  # Nếu không có text, hiển thị response trực tiếp

#     # Thêm phản hồi của chatbot vào lịch sử tin nhắn
#     if "image" in response and response["image"]:
#         st.session_state.messages.append({"role": "assistant", "content": response.get("text", response), "image": response["image"]})
#     else:
#         st.session_state.messages.append({"role": "assistant", "content": response.get("text", response)})

