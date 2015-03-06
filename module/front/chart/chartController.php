<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of chartcontroller
 *
 * @author factif
 */
class chartController extends Controller {
    
    function __construct() {
        parent::__construct();
        		$this->authorize();
                $this->loadMenu();
    }
    public function overview(){

		$this->setTitle('Overzicht Chart');
                
		$this->loadModel('chart');
		
		$categorys = $this->model->getChartData();
 
                $this->categorys = $categorys;
		
                $this->render('chart_overview.tpl');
	}
}
