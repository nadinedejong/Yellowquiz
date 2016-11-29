<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br><br><br>

  <script type="application/javascript">
	const r_t = 80; //straal tafel
	const r_s = 20; //straal stoel
	const R = r_s+r_t; //straal stoel+tafel
    function draw() { 
      
        $.get("alletafels", function(data){
        	  console.log("ontvangen: ", data);  
        	  drawTables(data);
          });
      }
     
	function drawTables(data){
		var canvas = document.getElementById("canvas");
        var ctx = canvas.getContext("2d");	
        ctx.beginPath();
		var j=0, k=0, i=0;
		var x_t, y_t; 
		var aantalStoelen = 6; 
		while (i<data.length){
			x_t = 1.5*r_t+j;
			y_t = 1.5*r_t+k;
			drawCircle(x_t, y_t, r_t, ctx);
			drawChairs(x_t, y_t, data, i, ctx);
			j += 4*r_t; 
			i++;
			if (i%3 ==0 && i !=0) {
				j = 0;
				k += 3.5*r_t;
			}
		}
		ctx.stroke();
	}
	
    function drawCircle(x, y, r, ctx) {
   		ctx.moveTo(x+r,y);
    	ctx.arc(x,y,r,0, 2*Math.PI,true);
  //  	ctx.fillStyle = 'lightgreen';
  //  	ctx.fill();
  //  	ctx.lineWidth = 3;
  //    ctx.strokeStyle = '#003300';
    }
    
  	function drawChairs(x_t, y_t, data, i, ctx){
  		var aantalStoelen = data[i].stoelen;
		var ang = 2*Math.PI/aantalStoelen;
   		var ang_s=0, x_s, y_s, j=0;   	
	
		for (; ang_s<2*Math.PI; ang_s+=ang, j++){
   			x_s = x_t + R*Math.cos(ang_s);
  			y_s = y_t + R*Math.sin(ang_s);
 			drawCircle(x_s, y_s, 20, ctx);
 			printName(x_s, y_s, data, i, j, ctx);
 		}
  	}  
  	
  	function printName(x_s, y_s, data, i, j, ctx){
  		ctx.font="20px Verdana";
  		ctx.fillStyle = 'black';
  		if (data[i].gasten[j] != null){
  			ctx.fillText(data[i].gasten[j].naam, x_s, y_s);
  		}	
  	}
    window.onload=draw; 
  </script>
 
   <canvas id="canvas" width="1500" height="5500"></canvas>