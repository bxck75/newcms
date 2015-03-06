<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of chartcontroller
 *
 * @author boudewijn kooy
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
		
		$this->ChartDataFeed = $this->model->getChartData();
		
                $this->render('chart_overview.tpl');
	}
}
