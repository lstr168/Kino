<?php
    session_start();
    set_include_path(get_include_path() . PATH_SEPARATOR . $_SERVER["DOCUMENT_ROOT"]. "/../" ."/libary");
    $mytext = "";
    $returnurl = "/";
    if(isset($_POST["Username"]) && isset($_POST["Passwort"]))
    {
        require_once("general.php");
        if(($typ = CheckPassword($_POST["Username"], $_POST["Passwort"])) !== "")
        {
            $_SESSION["LOGINUSER"] = $_POST["Username"];
            $_SESSION["LOGINTYP"] = $typ;
            $_SESSION["LOGINTIME"] = strtotime("now");
            if(isset($_SESSION["ReturnUrl"]) && $_SESSION["ReturnUrl"] != NULL)
                $returnurl = $_SESSION["ReturnUrl"];
            $_SESSION["ReturnUrl"] = NULL;                
            redirect($returnurl);
        }
        else 
        {
            $mytext = '<tr><td colspan="2"><p style="color:red;">Bitte überprüfen Sie Ihren eingaben!</p></td></tr>';
        }
    }
    else
    {
        if(isset($_SESSION["ReturnUrl"]) && $_SESSION["ReturnUrl"] != NULL)
            $returnurl = $_SESSION["ReturnUrl"];
        session_destroy();
        session_start();
        $_SESSION["ReturnUrl"] = $returnurl;
    }
    /*
    require_once("getSqlConnection.php");
    $sqlcon = getSqlCon(); 
    $x = $sqlcon->prepare("SELECT * From t_Land WHERE ID < ?");
    $myval = 10;
    $x->bind_param("i", $myval);
    $x->execute();
    $x->bind_result($res1, $res2);
    while($x->fetch())
    {
        echo "$res1 - $res2 <br />";
    }*/   
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="http://fonts.googleapis.com/css?family=Signika:300,600&amp;subset=latin,latin-ext" rel="stylesheet" type="text/css" /><link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,800italic,800" rel="stylesheet" type="text/css" />
    <link href="Style/base.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/jquery.js" language="javascript"></script>
  <title>Star Movies</title>
</head>
<body>
</div>
    <div class="header">
      <div class="page">
         <div class="title">
            <a href="/"><img src="/Images/title.png" alt="Star Movies Logo" width="200px" height="100px" /></a>
         </div>
         <div class="menu">
                <div class="clear"></div>
                <div class="mainmenu">
                    <div class="menuentry">
                        <a href="/">Start</a>
                    </div>
                    <div class="menuentry">
                        <a href="MovieOverview.php">Filme</a>
                    </div>
                    <div class="menuentry">
                        <a href="CinemaOverview.php">Kinos</a>
                    </div>
                    <div class="menuentry">
                        <a href="/">Kontakt</a>
                    </div>
                </div>
         </div>
      </div>
    </div>
    <div class="page">
        <div class="main">
            
  <div class="Teaser">
   <div class="col1">
     <br /><br /><br />
     <div style="font-weight:800;color: #1acdc9;font-size: 2.8em;padding-bottom:20px;">STAR MOVIES</div>
     <div style="font-weight:300;color:#68696b;font-size:2.3em;">Watch the star, watch us.</div>
     <br />
     <div style="font-family: Signika;font-style:normal;font-size: 1.25em;line-height:1.7em;">
       <form id="LoginForm" action="<?PHP echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post">
            <table>
                <tbody>
                    <?php echo $mytext ?> 
                    <tr>
                        <td>Benutzername:</td>
                        <td>
                            <input name="Username" type="text" />
                        </td>
                    </tr>
                    <tr>
                        <td>Passwort:</td>
                        <td>
                            <input name="Passwort" type="Password" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <a style='color:#000;height:30px;padding-left:28px; display: block;background-size:100px 30px; background-image:url("/images/button_bg.png");background-repeat: no-repeat;' href="javascript:document.getElementById('LoginForm').submit()">
                                Login
                            </a> 
                            <input type="submit" style="visibility:hidden;width:0;height:0;"/>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
     </div>
   </div>
   <div class="col2">
     <br /><br />
     <img src="/Images/movie.png" width="400px" height="260px" alt="Movie Image"  />
   </div>
  </div>   
  <div class="clear"></div>
  <br />
  </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear"></div>
    <br /><br /><br />
    <div class="footer">
      <div class="page">
        <div class="col1">
            <b>Ticket Reservieren</b><br /><br />
            <a href="/login.php">Login</a><br />
            <a href="/">FAQ</a>
        </div>
        <div class="col2">
            <b>FILME</b><br /><br />
            <a href="/">Jetzt im Kino</a><br />
            <a href="/">Bald im Kino</a><br />
            <a href="/">IMAX</a><br />
            <a href="/">Trailer</a><br />
            <br />
            <b><a href="/Impressum.aspx">IMPRESSUM</a></b><br /><br />
            <b><a href="/AGB.pdf" target="_blank">AGB</a></b><br />
        </div>
        <div class="col3">
            <b>KONTAKT</b><br /><br />
            Star Movies GmbH<br />
            <a href="maps:address=Hauptplatz 1, A-9500 Villach, Austira">Justastreet 1<br />
            A-9500 Villach<br />
            Austria<br />
            </a>
            <a href="tel:+43424212345">+43 4242 12345</a> Fax: <a href="fax:+4342421234599">DW-99</a><br />
            <a href="mailto:office@starmovies.test">office@starmovies.test</a><br />
        </div>
      </div>
    </div>
    </form>
</body>
</html>