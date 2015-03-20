<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of fancycontroller
 *
 * @author Boudewijnwerk
 */
class fancyController extends Controller{
    	public function __construct(){
		parent::__construct();
		
		$this->authorize();
                $this->loadMenu();
        }
    //put your code here
    public function vectorjs(){
       $this->render("fancy_vectorjs.tpl");
    }
}

?>
