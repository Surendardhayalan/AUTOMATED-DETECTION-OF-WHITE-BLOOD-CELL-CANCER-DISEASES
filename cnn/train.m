% Load data from Excel file
data = xlsread('trainn.xlsx');

% Extract features (columns 1 to 6)
features = data(:, 1:6);

% Extract class labels (7th column)
labels = data(:, 7);

% Ensure that labels are column vectors
labels = labels';  % Transpose labels to make it a column vector

% Convert labels to categorical
categorical_labels = categorical(labels);

% Reshape features to be compatible with fully connected layers
features = reshape(features', [1, 1, size(features, 2), size(features, 1)]);

% Define CNN architecture
layers = [
    imageInputLayer([1 1 6]) % Assuming 6 features
    fullyConnectedLayer(64)
    reluLayer
    fullyConnectedLayer(32)
    reluLayer
    fullyConnectedLayer(4) % Adjust the number of neurons to match the number of classes
    softmaxLayer
    classificationLayer
];

% Set the training options
options = trainingOptions('sgdm', ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 32, ...
    'InitialLearnRate', 0.001, ...
    'Plots', 'training-progress');

% Train the CNN
net = trainNetwork(features, categorical_labels, layers, options);

% Save the trained neural network model
save('mymodel.h2.mat', 'net');


