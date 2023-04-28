% Insert the confusion matrix
confusion_matrix = [308 96 16; 96 156 48; 35 41 44];

% Calculate the number of classes
num_classes = size(confusion_matrix, 1);

% Calculate the class-specific accuracies
class_accuracies = zeros(num_classes, 1);
for i = 1:num_classes
    class_accuracies(i) = confusion_matrix(i,i) / sum(confusion_matrix(i,:));
end

% Calculate the balanced accuracy as the average of the class-specific accuracies
balanced_accuracy = mean(class_accuracies);