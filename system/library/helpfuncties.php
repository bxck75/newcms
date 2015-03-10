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
    
    public function array_to_csv($data,$args=false) {
        if (!is_array($args)) { $args = array(); }
        foreach (array('download','line_breaks','trim') as $key) {
            if (array_key_exists($key,$args)) { $$key = $args[$key]; } else { $$key = false; }
        }

        //for this to work, no output should be sent to the screen before this function is called
        if ($download) {
            if ((is_string($download)) && (substr($download,-4) == '.csv')) { $filename = $download; }
            else { $filename = 'download.csv'; }
            header('Content-Type:text/csv');
            header('Content-Disposition:attachment; filename='.$filename);
        }

        if ($line_breaks == 'windows') { $lb = "\r\n"; }
        else { $lb = "\n"; }

        //get rid of headers row, if it exists (headers should exist as keys)
        if (array_key_exists('headers',$data)) { unset($data['headers']); }

        $i = 0;
        foreach ($data as $row) {
            $i++;
            //display headers
            if ($i == 1) { 
                $c = '';
                foreach ($row as $key => $value) {
                    $key = str_replace('"','""',$key);
                    if ($trim) { $key = trim($key); }
                    echo $c.'"'.$key.'"'; $c = ',';
                }
                //echo $lb;
            }

            //display values
            $c = '';
            foreach ($row as $key => $value) {
                $value = str_replace('"','""',$value);
                if ($trim) { $value = trim($value); }
                echo $c.'"'.$value.'"'; $c = ',';
            }
            echo $lb;
        }

        if ($download) { die(); }
    }
    
    public function vardrop($data,$pre = true,$die = false){
        if($pre == true){echo '<pre>';}
        var_dump($data);
        if($pre == true){echo '</pre>';}
        if($die == true){die('Killed on request!');}
    }
    public function schrijf($data,$pre = true,$die = false){
        if($pre == true){echo '<pre>';}
        echo $data;
        if($pre == true){echo '</pre>';}
        if($die == true){die('Killed on request!');}
    }

}
