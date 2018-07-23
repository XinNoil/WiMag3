# data version
- fingerprints1.mat 
    + 处理程序：run_process
    + 处理说明：默认将未收到的AP的RSSI值置为-100，然后求均值

- fingerprints2.mat
    + 处理程序：run_process2
    + 处理说明：忽略未收到的AP的RSSI值，求收到的RSSI值的均值	

- fingerprints3.mat
    + 弃置

- fingerprints4.mat
    + 弃置

- fingerprints5.mat
    + 处理程序：process_origin_data
    + 处理说明：默认将未收到的AP的RSSI值置为-100，取2:end-1秒的求均值，。

- testdatas5.mat
    + 处理程序：process_origin_data
    + 处理说明：取测试点end-1:end1

- testdatas5_1.mat
    + 处理程序：process_origin_data_1
    + 处理说明：取参考点end-1:end

- testdatas5_1.mat
    + 处理程序：process_origin_data_2
    + 处理说明：取参考点end-1:end和测试点end-1:end