------
### **GENERAL MODEL**
_2× Tesla V100S-PCIE-32GB -> max tokens (batch size) = 8000 -> 1 epoch = 4h_

------

learning rate: 7*e-4
- epoch 1 @ 62877 updates, score 4.018

- epoch 2 @ 125754 updates, score 3.919

- epoch 3 @ 188631 updates, score 3.867

- epoch 4 @ 25799 updates, score 3.821

- epoch 5 @ 29584 updates, score 3.786

- epoch 6 @ 59174 updates, score 3.738

- epoch 7 @ 25798 updates, score 3.757

- epoch 8 @ 51604 updates, score 3.701

FloatingPointError: Minimum loss scale reached (0.0001). Your loss is probably exploding. Try lowering the learning rate, using gradient clipping or increasing the batch size.
new learning rate: 0.001

- epoch 9 @ 25790 updates, score 8.589


------
### **FINE TUNING**
_2× Tesla V100S-PCIE-32GB -> max tokens (batch size) = 8000 -> 1 epoch = 1min_

------

