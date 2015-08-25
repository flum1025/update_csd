Update_CSD
===========

##What is it?

[CSD](http://github.com/flum1025/csd)にデータを送信するやつです。  
linux用です。windowsはめんどくさくて作るのやめました。  

動作確認はruby 2.0.0p481とruby 1.9.3p484です。

##How to Use
環境に合わせてURLと、

```
:TEMP=>`cat /sys/class/thermal/thermal_zone0/temp`.chomp,  
```

のthermal_zone0の部分を変更してください。  
ubuntu14.04の場合thermal_zone2でCPU温度が取得できました。  

cronに登録しておくと自動でデータを送信できます。  
  

質問等ありましたらTwitter:[@flum_](https://twitter.com/flum_)までお願いします。

##License

The MIT License

-------
(c) @2015 flum_
