<?php
class catagorieController extends Controller{
	public function __construct(){
		parent::__construct();
		
		$this->authorize();
                $this->loadMenu();
                
                $this->language->load('catagorie', $this->user['language']); //overal beschikbaar
		
		$this->label_catagorie = $this->language->get('label_catagorie_overview');		
		$this->label_catagorie_name = $this->language->get('label_catagorie_name');		
		$this->label_catagorie_id = $this->language->get('label_catagorie_id');		
		$this->label_catagorie_einddatum = $this->language->get('label_catagorie_einddatum');		
		$this->label_catagorie_parent_id = $this->language->get('label_catagorie_parent_id');		
		$this->label_catagorie_edit = $this->language->get('label_catagorie_edit');		
		$this->label_catagorie_delete = $this->language->get('label_catagorie_delete');		
		$this->label_catagorie_pdf = $this->language->get('label_catagorie_pdf');		
		$this->label_category_child = $this->language->get('label_category_child');		

                

                $this->addStyle('//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css');
	}

	public function overview(){

		$this->setTitle('Overzicht catagories');
                
                $this->loadModel('catagorie');
		
		$catagories = $this->model->getCatagories();
                //echo "<pre>";var_dump($catagories);echo "</pre>"; 
                
	

		$this->catagories = $catagories;
		
       
	        
		

		$this->render('catagorie_overview.tpl');
	}

	public function add(){
            
                $this->addScript('//code.jquery.com/jquery-1.11.2.min.js');
                
                $this->addScript('//code.jquery.com/ui/1.11.2/jquery-ui.js'); 
                
		$this->setTitle('Catagorie toevoegen');

		if($_POST){
                    
			$this->loadModel('catagorie');

			$this->model->addCatagorie($_POST);
			
			$this->msg = 'Catagorie '.$_POST['req_name'].' werd toegevoegd.';
			
			$this->overview();
		}else{		
			

			$this->catagorie = array(
				'name'			=> '',
				'parent_id'	=> ''
			);
			
			
                        
			$this->render('catagorie_detail.tpl');		
		}
	}

	public function edit(){
            
                            
                $this->addScript('//code.jquery.com/jquery-1.11.2.min.js');
                
                $this->addScript('//code.jquery.com/ui/1.11.2/jquery-ui.js');
                
		$this->setTitle('Catagorie aanpassen');

		$this->loadModel('catagorie');

		if($_POST){
			if($this->validate($_POST)){
				$this->model->editCatagorie($_POST);

				$this->msg = 'Catagorie '.$_POST['req_name'].' werd aangepast.';
			}						

			$this->overview();
		}
		
		if(isset($_GET['id'])){
			$id = $_GET['id'];
			
			$this->catagorie = $this->model->getCatagorie($id);
			
                        $this->catagorie_childs = $this->model->getCategorieChilds($id);
			
			$this->render('catagorie_detail.tpl');		
		}
	}

	public function delete(){
		if(isset($_GET['id'])){
			$id = $_GET['id'];
	
			$this->loadModel('catagorie');
			
			$catagorie = $this->model->getCatagorie($id);
			
			$this->model->deleteCatagorie($id);
			
			$this->msg = 'U heeft catagorie '.$catagorie['name'].' verwijderd.';
		}
		
		$this->overview();
		//$this->redirect('index.php?route=catagorie/overview');
	}


	public function catagorie_pdf(){
		if(isset($_GET['id'])){
			// inladen html2pdf uit Library
			require_once('system/library/html2pdf.class.php');		

			$id = $_GET['id'];
			$this->loadModel('catagorie');
			$this->catagorie = $this->model->catagoriePdf($id);
			$this->catagorie['total_rate'] = 0;
			
			if($this->catagorie['locations_array'] != '') $this->createArray('locations', $this->catagorie['locations_array']);			
			if($this->catagorie['artists_array'] != '') $this->createArray('artists', $this->catagorie['artists_array']);
			if($this->catagorie['resources_array'] != '') $this->createArray('resources', $this->catagorie['resources_array']);

			ob_start();
			require('themes/'.THEME.'/catagorie_pdf.tpl');
			$content = ob_get_contents();
			ob_end_clean();
			
			$html2pdf = new HTML2PDF('P','A4','nl');
  	 		$html2pdf->WriteHTML($content);
			$html2pdf->Output('catagorie'.$id.'.pdf');
		}
	}
	
	private function createArray($type, $data){
		$data = rtrim($data, '#');
	//	print_r($data);
		$array1 = explode('#,', $data);
		$i = 0;
		foreach($array1 as $item){
			$array2 = explode('|', $item);
			$this->catagorie[$type][$i]['name']=$array2[0];
			$this->catagorie[$type][$i]['desc']=$array2[1];
			$this->catagorie[$type][$i]['rate']=$array2[2];

			$this->catagorie['total_rate'] += $this->catagorie[$type][$i]['rate'];
			$i++;
			}
		
		}
	
	private function validate($data){
		foreach($data as $k => $v){
			if(substr($k, 0, 3) == 'req'){
				if($v == ''){
					return false;
				}
			}
			
			if(substr($k, 0, 6) == 'reqnum'){
				if(!is_numeric($v)){
					return false;
				}
			}
		}
		
		return true;
	}
}
