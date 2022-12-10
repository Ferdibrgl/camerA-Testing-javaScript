<%@ Page Title="" Language="C#" MasterPageFile="~/MDImaster/MDIMain.Master" AutoEventWireup="true" CodeBehind="camera_testing.aspx.cs" Inherits="PrjAutoShop.Test_Drive.camera_testing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #videoElement
        {
            width: 192px;
            height: 192px;
            background: rgba(0, 0, 0, 0.2);
            -webkit-transform: scaleX(-1); /* mirror effect while using front cam */
            transform: scaleX(-1); /* mirror effect while using front cam */
        
      
            transform: rotateY(180deg);
            -webkit-transform: rotateY(180deg); /* Safari and Chrome */
            -moz-transform: rotateY(180deg); /* Firefox */
        }

        #canvas {
            width: 192px;
            height: 192px;
            -webkit-transform: scaleX(-1); /* mirror effect while using front cam */
            transform: scaleX(-1); /* mirror effect while using front cam */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
   


    <div class="container p-5" align="center">
        <div class="">
            <b>Your Cam:</b><br>
            <video id="camera-stream" class="border border-5 border-danger"></video>
        </div>
        <div class="">
            <button id="flip-btn" type="button" disabled="disabled" class="btn btn-sm btn-warning">
                Flip Camera
            </button>
           
            <button type="button" id="capture-camera" class="btn btn-sm btn-primary">
                Take photo
            </button>
        </div>
        <div class="mt-3">
            <b>Capture image:</b>
            <br>
             <canvas id="canvas" class="bg-light shadow border border-5 border-success"></canvas>
            <div>
                <%--<a id="download" download="myImage.jpg" onclick="download_img(this);">Download</a>--%>
                 <input type="button" id="btnUpload" value="Upload"  />
                </div>
        </div>
  </div>
 
   <input type="hidden" id="FromBase64String" runat="server" />
   
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="../Scripts/webcam.min.js"></script>
    <script type="text/javascript">

        // camera stream video element
        let: on_stream_video = document.querySelector('#camera-stream');
        // flip button element
        let: flipBtn = document.querySelector('#flip-btn');

        // default user media options
        let: constraints = { audio: false, video: true }
        let: shouldFaceUser = true;

        // check whether we can use facingMode
        let: supports = navigator.mediaDevices.getSupportedConstraints();
        if( supports['facingMode'] === true ) {
            flipBtn.disabled = false;
        }

        let: stream = null;

        function capture() {
            constraints.video = {
                width: {
                    min: 192,
                    ideal: 192,
                    max: 192,
                },
                height: {
                    min: 192,
                    ideal: 192,
                    max: 192
                },
                facingMode: shouldFaceUser ? 'user' : 'environment'
            }
            navigator.mediaDevices.getUserMedia(constraints)
              .then(function(mediaStream) {
                  stream  = mediaStream;
                  on_stream_video.srcObject = stream;
                  on_stream_video.play();
              })
              .catch(function(err) {
                  console.log(err)
              });
        }

        flipBtn.addEventListener('click', function () {
            if (stream == null) return
            // we need to flip, stop everything
            stream.getTracks().forEach(function (track) {
                track.stop();
            });

       
            shouldFaceUser = !shouldFaceUser;
            capture();
        });

        capture();

        document.getElementById("capture-camera").addEventListener("click", function () {
            // Elements for taking the snapshot
           let: video = document.querySelector('video');
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            canvas.getContext('2d').drawImage(video, 0, 0);
        });

        var canvas = document.getElementById("canvas");
        var ctx = canvas.getContext("2d");
        download_img = function (el) {
        };

        $("#btnUpload").click(function () {
            var imageURI = canvas.toDataURL("image/jpg");

            var data = JSON.stringify(imageURI);

            //var userPreference;

            //if (confirm("Do you want to upload image?") == true) {
            //    userPreference = "image uploaded successfully!";
            //} 

            //document.getElementById("msg").innerHTML = userPreference;

            $.ajax({
                type: "POST",
                url: "camera_testing.aspx/SaveCapturedImage",
                data: "{data: '" + (imageURI) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (d) { }
                //success: function (data) {

                //    alert(data.d); // Success function
                //    $("#canvas").trigger('click');
                //}
                //error: function (result) {

                //    alert(result.d); //Error function

                //}
          

            });
        });
       
       
    </script>
 

</asp:Content>
