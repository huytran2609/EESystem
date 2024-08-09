import torch
import torch.nn as nn
import torch.nn.functional as F

# class NeuralNet(nn.Module):
#     def __init__(self, input_size, hidden_size, num_classes):
#         super(NeuralNet, self).__init__()
#         self.l1 = nn.Linear(input_size, hidden_size)
#         self.l2 = nn.Linear(hidden_size, hidden_size)
#         self.l3 = nn.Linear(hidden_size, num_classes)
#         self.relu = nn.ReLU()
    
#     def forward(self, x):
#         out = self.l1(x)
#         out = self.relu(out)
#         out = self.l2(out)
#         out = self.relu(out)
#         out = self.l3(out)
#         # no activation and no softmax at the end
#         return out

# class NeuralNet(nn.Module):
#     def __init__(self, input_size, hidden_size1, hidden_size2, hidden_size3, num_classes):
#         super(NeuralNet, self).__init__()
#         self.l1 = nn.Linear(input_size, hidden_size1)
#         self.l2 = nn.Linear(hidden_size1, hidden_size2)
#         self.l3 = nn.Linear(hidden_size2, hidden_size3)
#         self.l4 = nn.Linear(hidden_size3, num_classes)
#         self.relu = nn.ReLU()
    
#     def forward(self, x):
#         out = self.l1(x)
#         out = self.relu(out)
#         out = self.l2(out)
#         out = self.relu(out)
#         out = self.l3(out)
#         out = self.relu(out)
#         out = self.l4(out)
#         return out

# class NeuralNet(nn.Module):
#     def __init__(self, input_size, hidden_size1, hidden_size2, hidden_size3, num_classes, dropout_prob=0.5):
#         super(NeuralNet, self).__init__()
#         self.l1 = nn.Linear(input_size, hidden_size1)
#         self.l2 = nn.Linear(hidden_size1, hidden_size2)
#         self.l3 = nn.Linear(hidden_size2, hidden_size3)
#         self.l4 = nn.Linear(hidden_size3, num_classes)
#         self.relu = nn.ReLU()
#         self.dropout = nn.Dropout(p=dropout_prob)
    
#     def forward(self, x):
#         out = self.l1(x)
#         out = self.relu(out)
#         out = self.dropout(out)
#         out = self.l2(out)
#         out = self.relu(out)
#         out = self.dropout(out)
#         out = self.l3(out)
#         out = self.relu(out)
#         out = self.dropout(out)
#         out = self.l4(out)
#         return out
 
class NeuralNet(nn.Module):
    def __init__(self, input_size, hidden_size1, hidden_size2, hidden_size3, hidden_size4, num_classes, dropout_prob=0.5):
        super(NeuralNet, self).__init__()
        self.l1 = nn.Linear(input_size, hidden_size1)
        self.l2 = nn.Linear(hidden_size1, hidden_size2)
        self.l3 = nn.Linear(hidden_size2, hidden_size3)
        self.l4 = nn.Linear(hidden_size3, hidden_size4)
        self.l5 = nn.Linear(hidden_size4, num_classes)
        self.leakyrelu = nn.LeakyReLU(negative_slope=0.01)
        self.dropout = nn.Dropout(p=dropout_prob)

    def forward(self, x):
        out = self.l1(x)
        out = self.leakyrelu(out)
        out = self.dropout(out)
        out = self.l2(out)
        out = self.leakyrelu(out)
        out = self.dropout(out)
        out = self.l3(out)
        out = self.leakyrelu(out)
        out = self.dropout(out)
        out = self.l4(out)
        out = self.leakyrelu(out)
        out = self.dropout(out)
        out = self.l5(out)
        return out    

# class NeuralNet(nn.Module):
#     def __init__(self, input_size, hidden_size, num_classes):
#         super(NeuralNet, self).__init__()
#         self.l1 = nn.Linear(input_size, hidden_size) 
#         self.l2 = nn.Linear(hidden_size, hidden_size) 
#         self.l3 = nn.Linear(hidden_size, num_classes)
#         self.relu = nn.ReLU()
    
#     def forward(self, x):
#         # Chuyển đổi dtype của tensor đầu vào x sang cùng dtype với các trọng số của mô hình
#         x = x.to(self.l1.weight.dtype)
        
#         out = self.relu(self.l1(x))
#         out = self.relu(self.l2(out))
#         out = self.l3(out)
#         # no activation and no softmax at the end
#         return out


# class NeuralNet(nn.Module):
#     def __init__(self, input_size, hidden_size, num_classes):
#         super(NeuralNet, self).__init__()
#         self.l1 = nn.Linear(input_size, hidden_size)
#         self.l2 = nn.Linear(hidden_size, hidden_size)
#         self.l3 = nn.Linear(hidden_size, num_classes)
#         self.relu = nn.LeakyReLU(0.01)

#     def forward(self, x):
#         x = x.to(self.l1.weight.dtype)
#         out = self.relu(self.l1(x))
#         out = self.relu(self.l2(out))
#         out = self.l3(out)
#         return out


# class NeuralNet(nn.Module):
#     def __init__(self, input_size, hidden_size, num_classes):
#         super(NeuralNet, self).__init__()
#         self.l1 = nn.Linear(input_size, hidden_size)
#         self.l2 = nn.Linear(hidden_size, hidden_size)
#         self.l3 = nn.Linear(hidden_size, num_classes)
#         self.relu = nn.ReLU()
#         self.dropout = nn.Dropout(0.2)  # Add dropout for regularization
    
#     def forward(self, x):
#         x = x.to(self.l1.weight.dtype)
#         out = self.relu(self.l1(x))
#         out = self.dropout(out)
#         out = self.relu(self.l2(out))
#         out = self.dropout(out)
#         out = self.l3(out)
#         return out



# class NeuralNet(nn.Module):
#     def __init__(self, input_size, hidden_size, output_size):
#         super(NeuralNet, self).__init__()
#         self.embedding = nn.Embedding(input_size, hidden_size)
#         self.lstm = nn.LSTM(hidden_size, hidden_size, batch_first=True)
#         self.fc = nn.Linear(hidden_size, output_size)

#     def forward(self, x):
#         embedded = self.embedding(x)
#         lstm_out, _ = self.lstm(embedded)
#         out = self.fc(lstm_out[:, -1, :])
#         return out