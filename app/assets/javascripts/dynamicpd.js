var code ; //定义验证码        
function createCode()   //生成验证码
     {    
       // srccode = document.getElementById("gtcode").value;    
       srccode = "";
       var codeLength = 6;//验证码的长度   
       var gtcode = document.getElementById("gtcode");   
       var selectChar = new Array(0,1,2,3,4,5,6,7,8,9);//所有候选组成验证码的字符，当然也可以用中文的   
            
       for(var i=0;i<codeLength;i++)   
       {   
       var charIndex = Math.floor(Math.random()*10);   
       srccode +=selectChar[charIndex];   
       }   

       // 把动态验证码通过浦发 api 发送
       // sendPasswd(srccode);

       if(gtcode)
       {   
         // gtcode.className="code";   
         gtcode.value = srccode;   
       }   
           
     }  
function validate ()   //验证验证码
     {   
       var inputCode = document.getElementById("input1").value;   
       // var inputCode = srccode;
       // 改成三元选择写法
       if(inputCode.length <=0)   
       {   
         alert("空的");   
       }   
       else if(inputCode != srccode )   
       {   
         alert("错了");   
       }   
       else   
       {   
         alert("对的");   
       }   
           
      }       

// function sendPassword(password)
//      {
//       var msg= 'hello world';
//        $.post('/your_url/jmsg/' + msg, function(data){

//         })

//       $("#select_link").click(function(){
//         $.ajax({
//           type: 'POST',
//           url: 'http://your_url/jmsg',
//           dataType: 'json',
//           data: {msg: "hello world"},
//           success: function(json, status, xhr){
//             // $("#show_message").html(json.message)
//           }
//         });
//       });
//      }
//jquery倒计时
$(function  () {
  //获取短信验证码
  var validCode=true;
  $(".getdynamicpd").click (function  () {
    var time=10;
    var code=$(this);
    if (validCode) {
      //生成新的验证码
      createCode();
      // 测试发送到后台
      var msg= 'hello world';
       $.post('/your_url/jmsg/' + msg, function(data){

        })


      validCode=false;
      $(".getdynamicpd").attr({"disabled":"disabled"});
    var t=setInterval(function  () {
      time--;
      code.html(time+"秒");
      if (time==0) {
        clearInterval(t);
      code.html("重新获取");
        validCode=true;
      $(".getdynamicpd").removeAttr("disabled");
      }
    },1000)
    }
  })
})