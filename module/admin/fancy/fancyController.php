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
    public function __construct() {
        parent::__construct();
        $this->authorize();
        $this->loadMenu();
        $this->language->load('fancy', $this->user['language']); //overal beschikbaar
        
        $this->label_fancy = $this->language->get('label_fancy_overview');		
	$this->label_fancy_name = $this->language->get('label_fancy_name');	
         
    }
    public function vectorjs(){
        $this->loadModel("fancy");
        $this->jsonNodestring = $this->model->getcatalogJson();
        $this->jsonLinkstring = $this->model->getcatalogJson(true);
        $this->render('fancy_vectorjs.tpl');
    }
    
    
    
}

?>
