import 'package:bzinga/authentication/MobileNumber.dart';
import 'package:bzinga/tour/location_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF202329),
        accentColor: Colors.amber,
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.normal, buttonColor: Color(0xFFF29F05)),
        fontFamily: 'Raleway',
      ),
      home: LocationAccess(),
//      home: HtmlContent(),
    );
  }
}

class HtmlContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("HTML")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Colors.red,
            ),
            HtmlWidget(htmlSmaple(), webView: false)
          ],
        ),
        /*child: Html(
            data: htmlSmaple(),
            //Optional parameters:
            padding: EdgeInsets.all(8.0),
            linkStyle: const TextStyle(
              color: Colors.redAccent,
              decorationColor: Colors.redAccent,
              decoration: TextDecoration.underline,
            ),
            onLinkTap: (url) {
              print("Opening $url...");
            },
            onImageTap: (src) {
              print(src);
            },
            //Must have useRichText set to false for this to work
            customRender: (node, children) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "custom_tag":
                    return Column(children: children);
                }
              }
              return null;
            },
            customTextAlign: (dom.Node node) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return TextAlign.justify;
                }
              }
              return null;
            },
            customTextStyle: (dom.Node node, TextStyle baseStyle) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return baseStyle.merge(TextStyle(height: 2, fontSize: 14));
                }
              }
              return baseStyle;
            },
          ),*/
      ),
    );
  }

  String htmlSmaple() {
    return """
                <script type="application/ld+json">
    { "@context" : "http://schema.org",
    "@type" : "Organization",
    "name" : "HY Dance Studios",
    "url" : "http://www.hydance.in",
    "sameAs" : [ "http://www.facebook.com/hydance.in",
    "http://instagram.com/hydance.in"]
    }
</script>
<html lang="en">

<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>HY Dance Studios</title>
    <!--REQUIRED STYLE SHEETS-->
    <!-- BOOTSTRAP CORE STYLE CSS -->
    <link href="http://www.hydance.in/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONTAWESOME STYLE CSS -->
    <link href="http://www.hydance.in/assets/css/font-awesome.min.css" rel="stylesheet" />
    <!-- VEGAS STYLE CSS -->
    <link href="http://www.hydance.in/assets/scripts/vegas/jquery.vegas.min.css" rel="stylesheet" />
    <!-- CUSTOM STYLE CSS -->
    <link href="http://www.hydance.in/assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body>

    <div class="loader"></div>

    <!-- MAIN CONTAINER -->
    <div class="container-fluid">
        <!-- NAVBAR SECTION -->
        <!-- END NAVBAR SECTION -->

        <div class="row" style="background-color:white;">
            <div class="col-md-2 col-md-offset-3 col-sm-12">
                <img src="http://www.hydance.in/assets/img/logo_m.png" alt="Hy Dance Studios" width="128" height="172" />
            </div>
            <div class="col-md-2" style="margin-left:50px; margin-top:10px;">
                <p style="font-family:Roboto;margin:0px;font-weight:bold">
                    <br />2nd Floor, SBR CV Towers
                    <br />above Karachi Bakery,
                    <br />Madhapur, Hyderabad,
                    <br />Telangana 500081
                    <br /><button style="background-color:#73cf40;" onclick="window.location.assign('https://www.google.co.in/maps/dir//Karachi+Bakery,+Plot+No.2,+Shop+No.5,+Sector+1,Techno+Enclave,+Madhapur,+HUDA+Techno+Enclave,+HITEC+City,+Hyderabad,+Telangana+500081/@17.4450287,78.3834872,17z/data=!4m15!1m6!3m5!1s0x3bcb915fdd94eae3:0xcc24092543efbeca!2sKarachi+Bakery!8m2!3d17.4450287!4d78.3856759!4m7!1m0!1m5!1m1!1s0x3bcb915fdd94eae3:0xcc24092543efbeca!2m2!1d78.3856759!2d17.4450287?hl=en')"> Get Directions</button>
                </p>
            </div>
            <div class="col-md-2" style="margin-top:30px;">
                <p style="font-family:Roboto;margin:0px;font-weight:bold">
                    Contact: +91-99855 70615
                    <br />YouTube: <a href="http://youtube.com/hydancestudios" target="_blank"> youtube.com/hydancestudios</a>
                    <br />Facebook: <a href="http://fb.com/hydance.in" target="_blank"> fb.com/hydance.in</a>
					<br />Instagram: <a href="http://instagr.am/hydance.in" target="_blank"> instagr.am/hydance.in</a>
					<br />E-mail: <a href="mailto:contact@hydance.in" target="_blank"> contact@hydance.in</a>
                </p>
            </div>
        </div>        <!-- MAIN ROW SECTION -->
        <div class="row">
            <div class="col-md-3 col-md-offset-3 col-sm-12">
                <!--<div id="movingicon">
                    <i class="fa fa-flask fa-spin icon-color"></i>
                    <br />
                    <div id="headLine"></div>
                </div>-->
                <img id="launchposter" src="http://www.hydance.in/assets/img/HyDanceStudios_Schedule.png" alt="Schedule" style="cursor:pointer;" />
            </div>
            <div class="row" style="margin-left:40px;">
                <div class="col-md-12 col-md-offset-4" style="margin-top:20px;">
                    <p>
                        <span style="font-size:25px; font-weight:900;">
                            Contact 
                        </span>
						<span style="font-size:25px; color:#73cf40; font-weight:900;">
                            +91-99855 70615
                        </span>
						<span style="font-size:25px; font-weight:900;">
                             or visit the studio to enroll.
                        </span>
                    </p>
                </div>
            </div>
			<div class="row" style="margin-top:0px;">
                <div class="col-md-12 col-md-offset-4">
                    <p>
                            Revamped website in the works. Untill then, Get <span style="color:#73cf40;">HY</span> on Dance.
                        <span style="font-size:20px; font-weight:900;">
                        </span>
                    </p>
                </div>
            </div>
            <!--/. HEAD LINE DIV-->
            <!--<div class="col-md-8 col-md-offset-2">
                <div id="counter"></div>
                <div id="counter-default" class="row">
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="inner">
                            <div id="day-number" class="timer-number"></div>
                            <div class="timer-text">DAYS</div>

                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="inner">
                            <div id="hour-number" class="timer-number"></div>
                            <div class="timer-text">HOURS</div>

                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="inner">
                            <div id="minute-number" class="timer-number"></div>
                            <div class="timer-text">MINUTES</div>

                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="inner">
                            <div id="second-number" class="timer-number"></div>
                            <div class="timer-text">SECOND</div>



                        </div>
                    </div>
                </div>

            </div>-->
            <!--/. COUNTER DIV-->
            <div class="col-md-6 col-md-offset-3">

                <div class="input-group">

                </div>
            </div>
            <!--/. SUBSCRIBE DIV-->
            <!--/. SOCIAL DIV-->
        </div>
        <!--END MAIN ROW SECTION -->
    </div>
    <!-- MAIN CONTAINER END -->
    <!--/. CONTACT MODAL POPUP DIV-->
    <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY  -->
    <script src="http://www.hydance.in/assets/plugins/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP CORE SCRIPT   -->
    <script src="http://www.hydance.in/assets/plugins/bootstrap.js"></script>
    <!-- COUNTDOWN SCRIPTS -->
    <script src="http://www.hydance.in/assets/plugins/jquery.countdown.js"></script>
    <script src="http://www.hydance.in/assets/js/countdown.js"></script>
    <!-- VEGAS SLIDESHOW SCRIPTS -->
    <script src="http://www.hydance.in/assets/plugins/vegas/jquery.vegas.min.js"></script>
    <!-- CUSTOM SCRIPTS -->
    <script src="http://www.hydance.in/assets/js/custom-image.js"></script>

</body>
</html>
              """;
  }
}
