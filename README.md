# Introduction

Label performance test on iOS. It uses UILabel, WJAsyncLabel, [YYLabel](https://github.com/ibireme/YYText).

# WJAsyncLabel

WJAsyncLabel is a simple asynchronous solution for rendering text. In contrast, YYLabel is more complicated and inconsistent with UILabel.

# UILabel

As seen here, UILabel does consume time on the main thread with drawing and displaying.

![](https://github.com/WeijunDeng/LabelTest/blob/master/UILabel.jpg?raw=true)

# Result

As a result, asynchronous solutions have perfect FPS， while UILabel make performance degradation, especially when Chinese character and Emoji exist.

It must also bo noted that, the heights for cell have been calculated and cached in advance, in all different situations.

![](https://github.com/WeijunDeng/LabelTest/blob/master/monitor.gif?raw=true)

# License

Whatever.
