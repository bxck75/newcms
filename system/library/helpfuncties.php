<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of helpfunc
 *
 * @author Desktop
 */
class helpfuncties {
    public $data;
    public function checkifathome($data,$sessioninfo=false){
        if($_SERVER['REMOTE_ADDR'] == '82.74.221.24'){
            echo "<div id='debug info'>Debug info shown here! : ".$data."</div><br/>";
            if($sessioninfo == true){
            echo "<div id='debug info'>Session info shown here! : ".var_dump($_SESSION)."</div><br/>";
            echo "<div id='debug info'>Session info shown here! : ".var_dump($_COOKIE)."</div><br/>";
            }
            //test if session works by destroying it ..
            //should land you at the login module next try to acces modules without login             
            //unset($_SESSION["auth"]); 
        }
    }
    public function jsdirect($to) {
        ?>
        <script type="text/javascript">
            $(document).ready(function(){
                window.location.replace("<?php echo $to ?>");
            })
        </script>
        <?php
        
    }
    public function curPageURL() {
         $pageURL = 'http';
         if ($_SERVER["HTTPS"] == "on") {$pageURL .= "s";}
         $pageURL .= "://";
         if ($_SERVER["SERVER_PORT"] != "80") {
            $pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
         } else {
            $pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
         }
         return $pageURL;
    }

}
