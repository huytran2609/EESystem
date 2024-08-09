import numpy as np
from underthesea import word_tokenize, text_normalize
# from gensim.models import KeyedVectors
import random

# Load mô hình Word2VecVN đã được huấn luyện trước
# word2vec_model = KeyedVectors.load_word2vec_format('./word2vec_model/baomoi.model.bin', binary=True)

# from underthesea import chunk

# # Định nghĩa văn bản
# text = "tài liệu tham khảo số 3 của môn học này thì các tác giả định nghĩa là dữ liệu là những gì chúng ta biết"

# # Sử dụng hàm chunk để phân đoạn câu
# chunks = chunk(text)

# # Khởi tạo mảng để lưu trữ các cụm danh từ
# noun_phrases = []

# # Khởi tạo chuỗi để lưu trữ các cụm tính từ
# adjective_phrases = ""

# # Lọc và thêm các cụm danh từ (NP) vào mảng và cụm tính từ (AP) vào chuỗi
# for phrase, pos_tag, chunk_tag in chunks:
#     if chunk_tag.startswith('B-NP'):
#         noun_phrases.append(phrase)
#         if adjective_phrases:  # Nếu chuỗi không rỗng, thêm dấu cách trước cụm mới
#             adjective_phrases += " "
#         adjective_phrases += phrase
#     elif chunk_tag.startswith('B-AP'):
#         # Thêm cụm tính từ vào chuỗi và đảm bảo có dấu cách giữa các cụm
#         if adjective_phrases:  # Nếu chuỗi không rỗng, thêm dấu cách trước cụm mới
#             adjective_phrases += " "
#         adjective_phrases += phrase
# noun_phrases.append(adjective_phrases)
# # Lọc và thêm các cụm danh từ (NP) và cụm tính từ (AP)
# # for phrase, pos_tag, chunk_tag in chunks:
# #     if chunk_tag.startswith('B-NP') or chunk_tag.startswith('I-NP'):
# #         # Kiểm tra từng cụm danh từ nếu chứa 2 chữ trở lên mới thêm vào mảng
# #         if ' ' in phrase:  # Kiểm tra có chứa dấu cách không, nếu có thì đó là cụm từ có từ 2 chữ trở lên
# #             noun_phrases.append(phrase)
# #     elif chunk_tag.startswith('B-AP'):
# #         # Thêm cụm tính từ vào chuỗi và đảm bảo có dấu cách giữa các cụm
# #         if adjective_phrases:  # Nếu chuỗi không rỗng, thêm dấu cách trước cụm mới
# #             adjective_phrases += " "
# #         adjective_phrases += phrase

# print("Các cụm danh từ được trích xuất:", noun_phrases)
# # print("Chuỗi các cụm tính từ được trích xuất:", adjective_phrases)




# Danh sách stopwords tiếng Việt
stopwords = set([
    "và", "hoặc", "mà", "thì", "là", "ở", "nhưng", "như", "tại", "với", "bởi",
    "vì", "do", "của", "trong", "ngoài", "giữa", "lên", "xuống", "này", "kia",
    "này nọ", "cái", "các", "một", "những", "đang", "đã", "sẽ", "chưa", "không",
    "phải", "từng", "cũng", "vẫn", "nhiều", "ít"
])

def tokenize(sentence):
    """
    tách câu thành mảng các từ/tokens
    một token có thể là từ hoặc dấu câu, hoặc số
    """
    # seg_sentence = word_tokenize(sentence, format="text")
    return word_tokenize(sentence)

def stem(word):
    """
    stemming = tìm ra hình thức gốc của từ
    ví dụ:
    words = ["học", "học", "học"]
    words = [stem(w) for w in words]
    -> ["học", "học", "học"]
    """
    return text_normalize(word.lower())

# def bag_of_words(tokenized_sentence, words):
#     """
#     trả về mảng bag of words:
#     1 cho mỗi từ đã biết có trong câu, 0 nếu ngược lại
#     ví dụ:
#     câu = ["xin", "chào", "các", "bạn"]
#     từ khóa = ["xin", "chào", "tôi", "bạn", "tạm_biệt", "cảm_ơn", "hay"]
#     bag   = [  1 ,    1 ,    0 ,   1 ,      0 ,        0 ,     0 ]
#     """
#     # stemming cho mỗi từ
#     sentence_words = [stem(word) for word in tokenized_sentence]
#     # khởi tạo bag với giá trị 0 cho mỗi từ
#     bag = np.zeros(len(words), dtype=np.float32)
#     for idx, w in enumerate(words):
#         if w in sentence_words: 
#             bag[idx] = 1

#     return bag
def bag_of_words(tokenized_sentence, words):
    """
    Trả về mảng bag of words với các từ đã biết trong câu.
    """
    # stemming và loại bỏ stopwords cho mỗi từ
    sentence_words = [stem(word) for word in tokenized_sentence if word not in stopwords]
    bag = np.zeros(len(words), dtype=np.float32)
    for idx, w in enumerate(words):
        if w in sentence_words:
            bag[idx] = 1
    return bag

# def get_sentence_vector(sentence):
#     """
#     Biểu diễn mỗi câu dưới dạng vector bằng cách lấy trung bình của các vector biểu diễn của các từ trong câu.
#     """
#     tokens = word_tokenize(sentence)
#     vector_list = []
#     for token in tokens:
#         try:
#             vector = word2vec_model[token]
#             vector_list.append(vector)
#         except KeyError:
#             # Nếu từ không tồn tại trong từ điển của Word2VecVN, bỏ qua
#             pass
#     if vector_list:
#         return np.mean(vector_list, axis=0)
#     else:
#         # Trong trường hợp không có từ nào trong câu tồn tại trong từ điển, trả về vector toàn số 0
#         return np.zeros(word2vec_model.vector_size)

# words = "weather chúng ta có từ khóa dự bị rôm Thì bên dưới mình sẽ đưa ra các ví dụ nhé đối với mình sẽ xét đối với các cái lược đồ"
# seg_sentence = word_tokenize(words, format="text")
# tokenized_sentence = tokenize(seg_sentence)
# print(tokenized_sentence)
# sentence_word = [stem(word) for word in tokenized_sentence]
# print(sentence_word)

# -------------------------------------------------------------
# # Tìm các từ tương đồng với một từ cho trước
# similar_words = word2vec_model.most_similar('khái_niệm', topn=10)
# print("Các từ tương đồng với 'khái_niệm' là:")
# for word, similarity_score in similar_words:
#     print("- {}: {:.2f}".format(word, similarity_score))
# # Kiểm tra vector của một từ
# word = 'khái_niệm'
# if word in word2vec_model:
#     print("Từ '{}' có trong từ điển.".format(word))
# else:
#     print("Từ '{}' không có trong từ điển.".format(word))
    
# # Lấy số lượng từ trong từ điển
# num_words = len(word2vec_model.key_to_index)
# print("Số lượng từ trong từ điển là:", num_words)

# Lấy danh sách các từ trong từ điển
# available_words = word2vec_model.index_to_key
# print(available_words[200:500])

