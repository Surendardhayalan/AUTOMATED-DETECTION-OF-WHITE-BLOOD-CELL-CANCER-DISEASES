% Load the trained model
loaded_model = load('mymodel.h2.mat');
net = loaded_model.net;

% Load test data from Excel file
test_image = xlsread('new.csv');

% Reshape the test image for prediction
test_image = reshape(test_image, [1, 1, 6]);
% Make predictions using the trained network

predicted_label = classify(net, test_image);

% Display the predicted label
disp('Predicted Label:');
disp(predicted_label);


