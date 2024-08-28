% Load the saved model
load('random_forest_model.mat');

% Load new data from the new spreadsheet
new_data_filename = 'new.csv';
new_data_sheet = 1;
new_data_range = 'A:F'; % Assuming your new data has 6 features in columns A to F
new_data = xlsread(new_data_filename, new_data_sheet, new_data_range);

% Extract features from the new data
X_new = new_data;

% Make predictions using the loaded model
y_pred_new = predict(rf, X_new);

% Convert predictions to numeric array
y_pred_new = str2double(y_pred_new);

% Display the predictions
disp('Predictions for the new data:');
disp(y_pred_new);
