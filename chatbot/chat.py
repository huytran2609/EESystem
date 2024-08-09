import random
import json
import os

import torch

from model import NeuralNet
from preprocessing import bag_of_words, tokenize

device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# with open('intents.json', 'r', encoding='utf-8') as json_data:
#     intents = json.load(json_data)
# with open('cosodulieu.json', 'r', encoding='utf-8') as json_data:
#     intents = json.load(json_data)

# # FILE = "data_example.pth"
# # FILE = "data_courses.pth"
# FILE = "cosodulieu.pth"
# # data = torch.load(FILE)
# data = torch.load(FILE, map_location=torch.device('cpu'))

# input_size = data["input_size"]
# # hidden_size = data["hidden_size"]
# hidden_size1 = data["hidden_size1"]
# hidden_size2 = data["hidden_size2"]
# hidden_size3 = data["hidden_size3"]
# hidden_size4 = data["hidden_size4"]
# output_size = data["output_size"]
# all_words = data['all_words']
# # print(all_words)
# tags = data['tags']
# model_state = data["model_state"]

# model = NeuralNet(input_size, hidden_size1, hidden_size2, hidden_size3, hidden_size4, output_size).to(device)
# model.load_state_dict(model_state)
# model.eval()
def load_data(namespace):
    json_path = f'{namespace}.json'
    pth_path = f'{namespace}.pth'

    if not os.path.exists(json_path) or not os.path.exists(pth_path):
        raise ValueError(f"Files for namespace '{namespace}' do not exist.")

    with open(json_path, 'r', encoding='utf-8') as json_data:
        intents = json.load(json_data)

    data = torch.load(pth_path, map_location=torch.device('cpu'))
    
    return intents, data


def get_response(user_message, namespace):
    intents, data = load_data(namespace)

    input_size = data["input_size"]
    hidden_size1 = data["hidden_size1"]
    hidden_size2 = data["hidden_size2"]
    hidden_size3 = data["hidden_size3"]
    hidden_size4 = data["hidden_size4"]
    output_size = data["output_size"]
    all_words = data['all_words']
    tags = data['tags']
    model_state = data["model_state"]

    model = NeuralNet(input_size, hidden_size1, hidden_size2, hidden_size3, hidden_size4, output_size).to(device)
    model.load_state_dict(model_state)
    model.eval()

    # Tokenize user message
    sentence = tokenize(user_message)
    # Create bag of words
    X = bag_of_words(sentence, all_words)
    X = X.reshape(1, X.shape[0])
    X = torch.from_numpy(X).to(device)

    # Get model prediction
    output = model(X)
    _, predicted = torch.max(output, dim=1)

    tag = tags[predicted.item()]
    print(tag)

    # Check if the predicted tag has high confidence
    probs = torch.softmax(output, dim=1)
    prob = probs[0][predicted.item()]
    print(prob)

    if prob.item() > 0.07:
        for intent in intents['intents']:
            if tag == intent["tag"]:
                response = intent['responses']
                if isinstance(response, list) and len(response) >= 2:  # If response is a list with text and image
                    return {"text": response[0], "image": response[1]}
                else:  # If response is only text
                    return {"text": response[0]}
    else:
        return {"text": "Bạn cần nhập chính xác nội dung cần tìm hơn..."}


# def get_response(user_message):
#     # Tokenize user message
#     sentence = tokenize(user_message)
#     # Create bag of words
#     X = bag_of_words(sentence, all_words)
#     X = X.reshape(1, X.shape[0])
#     X = torch.from_numpy(X).to(device)

#     # Get model prediction
#     output = model(X)
#     _, predicted = torch.max(output, dim=1)

#     tag = tags[predicted.item()]
#     print(tag)

#     # Check if the predicted tag has high confidence
#     probs = torch.softmax(output, dim=1)
#     prob = probs[0][predicted.item()]
#     print(prob)
#     # if prob.item() > 0.4:
#     #     for intent in intents['intents']:
#     #         if tag == intent["tag"]:
#     #             return random.choice(intent['responses'])
#     # else:
#     #     return "Xin lỗi, tôi không hiểu câu của bạn. Vui lòng nhập lại!"
#     if prob.item() > 0.07:
#         for intent in intents['intents']:
#             if tag == intent["tag"]:
#                 response = intent['responses']
#                 if isinstance(response, list) and len(response) >= 2:  # If response is a list with text and image
#                     return {"text": response[0], "image": response[1]}
#                 else:  # If response is only text
#                     return {"text": response[0]}
#     else:
        return {"text": "Bạn cần nhập chính xác nội dung cần tìm hơn..."}





# bot_name = "Bot"
# print("Let's chat! (type 'quit' to exit)")
# while True:
#     # sentence = "do you use credit cards?"
#     sentence = input("You: ")
#     if sentence == "quit":
#         break

#     sentence = tokenize(sentence)
#     X = bag_of_words(sentence, all_words)
#     X = X.reshape(1, X.shape[0])
#     X = torch.from_numpy(X).to(device)

#     output = model(X)
#     _, predicted = torch.max(output, dim=1)

#     tag = tags[predicted.item()]
#     # print(tag)

#     probs = torch.softmax(output, dim=1)
#     prob = probs[0][predicted.item()]
#     # print(prob)
    # if prob.item() > 0.4:
    #     for intent in intents['intents']:
    #         if tag == intent["tag"]:
    #             print(f"{bot_name}: {random.choice(intent['responses'])}")
    # else:
    #     print(f"{bot_name}: Bạn cần nhập chính xác nội dung cần tìm hơn...")