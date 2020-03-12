/*		function loadPage(){
			$.ajax({
				type: "POST",
				url: "loadPage.action",
				//data: params,
				dataType:"json", //ajax杩斿洖鍊艰缃负text锛坖son鏍煎紡涔熷彲鐢ㄥ畠杩斿洖锛屽彲鎵撳嵃鍑虹粨鏋滐紝涔熷彲璁剧疆鎴恓son锛�
				success: function(json){
					alert(json);
					var str = JSON.parse(json);
					alert(str);
					var obj = $.parseJSON(json);  //浣跨敤杩欎釜鏂规硶瑙ｆ瀽json
					var state_value = obj.result;  //result鏄拰action涓畾涔夌殑result鍙橀噺鐨刧et鏂规硶瀵瑰簲鐨�
					alert(state_value);
				},
				error: function(json){
					alert("json=" + json);
				    	return false;
				    }
			});
		 

		}*/
		function openControl(){
			var control = $('#tabControl');
			var monit = $('#tabMonit');
			control.addClass('active');
			monit.removeClass('active');
			location.reload();
		}
		function openMonit(){
			var control = $('#tabControl');
			var monit = $('#tabMonit');
			control.removeClass('active');
			monit.addClass('active');
		}
		function openLink(id){
			$('#center-column').html("");
			var linkName = "link"+id;
			var pointName = "point"+id;
			var link1 = $("#"+linkName);
			if(link1.hasClass('link-active')){
				link1.removeClass('link-active').addClass('link');
				$("#"+pointName).find("li").remove();
				$("#"+pointName).hide();
			}else {	
				$.get("loadConsoleIp.action",{ moduleId:id },
					function(consoleIps){
						$.each(JSON.parse(consoleIps),function(i,obj){
							$("#"+pointName).append(
								'<li id="'+obj.consoleId+'" onclick="openCore($(this))"><a style="cursor:pointer;">'+obj.consoleName+'</a></li>'
							);
						});
				});
				link1.addClass('link-active').removeClass('link');
				$("#"+pointName).show();
			}
			$("#center-column").load( "getControlPage.action",{modelName:name}, function( response) {							
				$('#center-column').html(response);
			});
		}
		
		function openLink1(){
			var link1 = $('#link1');
			if(link1.hasClass('link-active')){
				link1.removeClass('link-active').addClass('link');
				$('#point1').hide();
			}else {	
				link1.addClass('link-active').removeClass('link');
				$('#point1').show();
			}
			$('#center-column').html("");
			$("#center-column").load( "rightmid.jsp", function( response) {							
				$('#center-column').html(response);
			});
		}
		function openLink2(){
			var link2 = $('#link2');
			if(link2.hasClass('link-active')){
				link2.removeClass('link-active').addClass('link');
				$('#point2').hide();
			}else {	
				link2.addClass('link-active').removeClass('link');
				$('#point2').show();
			}
			$('#center-column').html("");
			$("#center-column").load( "rightmid.jsp", function( response) {							
				$('#center-column').html(response);
			});
		}
		
		//鏍规嵁鎺у埗鍙癷p 鎵撳紑瀵瑰簲鎿嶄綔椤甸潰
		function openCore(obj){
			var consoleIp = obj.text();
			var consoleId = obj.attr('id');
			$('#center-column').html("");
			$("#center-column").load( "newMain.action?openType=resetUpdate&consoleIp="+consoleIp+"&consoleId="+consoleId, function( response) {							
				$('#center-column').html(response);
			});
		}

		
		//鏇存柊闆嗙兢銆佺敓浜у埌 rabbitmq 涓�
		function updateCluster(name){
			var appName = $('#appName'+name).text();
			var contextRoot = $('#contextRoot'+name).text();
			var clusterName = $('#clusterName'+name).text();
			var opType = "wasUpdateCluster";
			var serverName  = "null";
			if(window.confirm("\nopType:"+opType+"\nappName:"+appName+"\ncontextRoot:"+contextRoot+"\nclusterName:"+clusterName+"\nserverName:"+serverName+"\n纭畾鏃犺?纭畾鍙戦�?")){
				$.ajax({
					type: "POST",
					url: "sendRabbitMQ.action",
///					data: {appName:appName,contextRoot:contextRoot, cluserName:cluserName,serverName:Null,opType:opType},
					data: {appName:appName,contextRoot:contextRoot, clusterName:clusterName,serverName:serverName,opType:opType},
					dataType: "text",
					success: function(data){
						window.alert(data);
					}
				});
			}
		}
		
		//鏇存柊server鍒皉abbitmq
		function updateServer(name){
			var appName = $('#appName'+name).text();
			var contextRoot = $('#contextRoot'+name).text();
			var clusterName = "null";
			var opType = "wasUpdateServer";
			var serverName  = $('#serverName'+name).text();
			if(window.confirm("\nopType:"+opType+"\nappName:"+appName+"\ncontextRoot:"+contextRoot+"\nclusterName:"+clusterName+"\nserverName:"+serverName+"\n纭畾鏃犺?纭畾鍙戦�?"))
			{
				$.ajax({
					type:"POST",
					url:"sendRabbitMQ.action",
					data:{appName:appName,contextRoot:contextRoot, clusterName:clusterName,serverName:serverName,opType:opType},
					dataType:"text",
					success:function(data){
						window.alert(data);
					}
				});				
			}
		}
		//鎵撳紑閲嶅惎鏇存柊椤甸潰
		function openResetUpdate(){
			$('#center-column').html("");
			$("#center-column").load( "newMain.action?openType=resetUpdate", function( response) {							
				$('#center-column').html(response);
			});
		}
		//鍙戞柊搴旂敤椤甸潰
		function openReleaseNewApp(){
			$('#center-column').html("");
			$("#center-column").load( "newMain.action?openType=releaseNewApp", function( response) {							
				$('#center-column').html(response);
			});
		}
		//寤烘暟鎹簱
		function openCreateData(){
			$('#center-column').html("");
			$("#center-column").load( "newMain.action?openType=createData", function( response) {							
				$('#center-column').html(response);
			});
		}
		//寤哄叡浜簱
		function openCreateLib(){
			$('#center-column').html("");
			$("#center-column").load( "newMain.action?openType=createLibrary", function( response) {							
				$('#center-column').html(response);
			});
		}
		//鏃ュ織鏌ョ湅
		function openCheckLog(){
			$('#center-column').html("");
			$("#center-column").load( "newMain.action?openType=checkLog", function( response) {							
				$('#center-column').html(response);
			});
		}
		//鏁版嵁婧愭煡鐪�
		function openCheckDat(){
			$('#center-column').html("");
			$("#center-column").load( "newMain.action?openType=checkDat", function( response) {							
				$('#center-column').html(response);
			});
		}
		//鎺у埗鍙板叏閫�
		function selectControls(){
			alert("鎺у埗鍙�");
		}
		//鑺傜偣鍏ㄩ�
		function selectNodes(){
			alert("鑺傜偣鍏ㄩ�");
		}
		//搴旂敤鍏ㄩ�
		function selectApps(){
			alert("搴旂敤鍏ㄩ�");
		}
		//闆嗙兢鍏ㄩ�
		function selectClusters(){
			alert("闆嗙兢鍏ㄩ�");
		}
		//server鍏ㄩ�
		function selectServers(){
			alert("server鍏ㄩ�");
		}
		
		function prom()
		{
			var name=prompt("搴旂敤鍖�,");
		    if(name)
		    {
		       alert("搴旂敤鍖咃細"+ name);
		    }
		}
		
		//鏀瑰彉涓婁紶鏂囦欢鐨勫悕瀛�
		function changeFileName(){
			var str = $('#uploadFile').val();
			$('#fileName').val(str);
		}
		
		//鏇存柊搴旂敤椤甸潰鍚姩搴旂敤war鍖�
		function startApp() {
//			var selectedApps = new Array();
//			var isTrue = false;
//			$('.table input:checked').parentsUntil('tr').parent().each(function(){
//				//鑾峰彇鎵�湁鍕鹃�鐨�
//				selectedApps.push({selectedApp: $(this).attr("applicationName")});
//				appName = $(this).attr("applicationName");
//			});
			
//			var isTrue = false;
//			$('.table input:checked').parentsUntil('td').parent().each(function(){
				//鑾峰彇鎵�湁鍕鹃�鐨�
//				selectedApps.push({selectedApp: $(this).attr("applicationName")});
//				appName = $(this).attr("applicationName");
				
//				window.alert($(this).value());
//			});
			var appName = $("input:radio[name='appNameRadio']:checked").val();
//	 	    alert('appName:'+appName);
			var contextRoot = "";
			var clusterName = "";
			var opType = "wasStartApp";
			var serverName  = "";
			if(window.confirm("\nopType:"+opType+"\nappName:"+appName+"\ncontextRoot:"+contextRoot+"\nclusterName:"+clusterName+"\nserverName:"+serverName+"\n纭畾鏃犺?纭畾鍙戦�?"))
			{
				$.ajax({
					type:"POST",
					url:"sendRabbitMQ.action",
					data:{appName:appName,contextRoot:contextRoot, clusterName:clusterName,serverName:serverName,opType:opType},
					dataType:"text",
					success:function(data){
						window.alert(data);
					}
				});				
			}
		}
		
		//鏇存柊搴旂敤椤甸潰鍋滄搴旂敤war鍖�
		
		function stopApp(){
			var appName = $("input:radio[name='appNameRadio']:checked").val();
			var contextRoot = "";
			var clusterName = "";
			var opType = "wasStopApp";
			var serverName  = "";
			if(window.confirm("\nopType:"+opType+"\nappName:"+appName+"\ncontextRoot:"+contextRoot+"\nclusterName:"+clusterName+"\nserverName:"+serverName+"\n纭畾鏃犺?纭畾鍙戦�?"))
			{
				$.ajax({
					type:"POST",
					url:"sendRabbitMQ.action",
					data:{appName:appName,contextRoot:contextRoot, clusterName:clusterName,serverName:serverName,opType:opType},
					dataType:"text",
					success:function(data){
						window.alert(data);
					}
				});				
			}			
		}
		
		
		//鏇存柊搴旂敤椤甸潰鍚姩闆嗙兢
		function startCluster(){
			var appName = $("input:radio[name='appNameRadio']:checked").val();
		//	alert('appName:'+appName);
			var contextRoot = "";
			var clusterName = $("input:radio[name='clusterNameRadio']:checked").val();
			var opType = "wasStartCluster";
			var serverName  = "";
			if(window.confirm("\nopType:"+opType+"\nappName:"+appName+"\ncontextRoot:"+contextRoot+"\nclusterName:"+clusterName+"\nserverName:"+serverName+"\n纭畾鏃犺?纭畾鍙戦�?")) 
			{
			  $.ajax({
				 type:"POST",
				 url:"sendRabbitMQ.action",
					data:{appName:appName,contextRoot:contextRoot, clusterName:clusterName,serverName:serverName,opType:opType},
					dataType:"text",
					success:function(data){
						window.alert(data);
					}
			  });	
			}
		}
		
		//鍋滄闆嗙兢
		function stopCluster(){
			var appName = $("input:radio[name='appNameRadio']:checked").val();
			var contextRoot = "";
			var clusterName = $("input:radio[name='clusterNameRadio']:checked").val();
			var opType = "wasStartCluster";
			var serverName  = "";
			if(window.confirm("\nopType:"+opType+"\nappName:"+appName+"\ncontextRoot:"+contextRoot+"\nclusterName:"+clusterName+"\nserverName:"+serverName+"\n纭畾鏃犺?纭畾鍙戦�?")) 
			{
			  $.ajax({
				 type:"POST",
				 url:"sendRabbitMQ.action",
					data:{appName:appName,contextRoot:contextRoot, clusterName:clusterName,serverName:serverName,opType:opType},
					dataType:"text",
					success:function(data){
						window.alert(data);
					}
			  });	
			}
		}
		
		//鍚姩server
		function startServer(){
			var appName = $("input:radio[name='appNameRadio']:checked").val();
			var contextRoot = "";
			var clusterName = "";
			var opType = "WasStartServer";
			var serverName = $("input:radio[name='serverNameRadio']:checked").val();			
			if(window.confirm("\nopType:"+opType+"\nappName:"+appName+"\ncontextRoot:"+contextRoot+"\nclusterName:"+clusterName+"\nserverName:"+serverName+"\n纭畾鏃犺?纭畾鍙戦�?")) 
			{
			  $.ajax({
				 type:"POST",
				 url:"sendRabbitMQ.action",
					data:{appName:appName,contextRoot:contextRoot, clusterName:clusterName,serverName:serverName,opType:opType},
					dataType:"text",
					success:function(data){
						window.alert(data);
					}
			  });	
			}
		}
		
		//鍋滄server
		function stopServer(){
			var appName = $("input:radio[name='appNameRadio']:checked").val();
			var contextRoot = "";
			var clusterName = "";
			var opType = "WasStopServer";
			var serverName = $("input:radio[name='serverNameRadio']:checked").val();
			if(window.confirm("\nopType:"+opType+"\nappName:"+appName+"\ncontextRoot:"+contextRoot+"\nclusterName:"+clusterName+"\nserverName:"+serverName+"\n纭畾鏃犺?纭畾鍙戦�?")) 
			{
			  $.ajax({
				 type:"POST",
				 url:"sendRabbitMQ.action",
					data:{appName:appName,contextRoot:contextRoot, clusterName:clusterName,serverName:serverName,opType:opType},
					dataType:"text",
					success:function(data){
						window.alert(data);
					}
			  });	
			}
		}