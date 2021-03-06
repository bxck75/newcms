<?php
class categoryController extends Controller{
	public function __construct(){
		parent::__construct();
		
		$this->authorize();
                $this->loadMenu();
                
                $this->language->load('category', $this->user['language']); //overal beschikbaar
		
		$this->label_category = $this->language->get('label_category_overview');		
		$this->label_category_name = $this->language->get('label_category_name');		
		$this->label_category_startdatum = $this->language->get('label_category_startdatum');		
		$this->label_category_einddatum = $this->language->get('label_category_einddatum');		
		$this->label_category_parent_id = $this->language->get('label_category_parent_id');		
		$this->label_category_edit = $this->language->get('label_category_edit');		
		$this->label_category_delete = $this->language->get('label_category_delete');		
		$this->label_category_pdf = $this->language->get('label_category_pdf');		

                
                $this->addScript('//code.jquery.com/jquery-1.11.2.min.js');
                $this->addScript('//code.jquery.com/ui/1.11.2/jquery-ui.js');
                $this->addStyle('//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css');
	}

	public function overview(){

		$this->setTitle('Overzicht categorys');
                
		
                

                
		$this->loadModel('category');
		
		$categorys = $this->model->getcategorys();
                 //echo "<pre>";var_dump($categorys);echo "</pre>"; 

	

		$this->categorys = $categorys;
		
       
	        
		

		$this->render('category_overview.tpl');
	}

	public function add(){
		$this->setTitle('category toevoegen');

		if($_POST){
                    
			$this->loadModel('category');

			$this->model->addcategory($_POST);
			
			$this->msg = 'category '.$_POST['req_name'].' werd toegevoegd.';
			
			$this->overview();
		}else{		
			

			$this->category = array(
				'name'			=> '',
				'parent_id'	=> ''
			);
			
			
                        
			$this->render('category_detail.tpl');		
		}
	}

	public function edit(){
		$this->setTitle('category aanpassen');

		$this->loadModel('category');

		if($_POST){
			if($this->validate($_POST)){
				$this->model->editcategory($_POST);

				$this->msg = 'category '.$_POST['req_name'].' werd aangepast.';
			}						

			$this->overview();
		}
		
		if(isset($_GET['id'])){
			$id = $_GET['id'];
			
			$this->category = $this->model->getcategory($id);
			
                       
			
			$this->render('category_detail.tpl');		
		}
	}

	public function delete(){
		if(isset($_GET['id'])){
			$id = $_GET['id'];
	
			$this->loadModel('category');
			
			$category = $this->model->getcategory($id);
			
			$this->model->deletecategory($id);
			
			$this->msg = 'U heeft category '.$category['name'].' verwijderd.';
		}
		
		$this->overview();
		//$this->redirect('index.php?route=category/overview');
	}


	public function category_pdf(){
		if(isset($_GET['id'])){
			// inladen html2pdf uit Library
			require_once('system/library/html2pdf.class.php');		

			$id = $_GET['id'];
			$this->loadModel('category');
			$this->category = $this->model->categoryPdf($id);
			$this->category['total_rate'] = 0;
			
			if($this->category['locations_array'] != '') $this->createArray('locations', $this->category['locations_array']);			
			if($this->category['artists_array'] != '') $this->createArray('artists', $this->category['artists_array']);
			if($this->category['resources_array'] != '') $this->createArray('resources', $this->category['resources_array']);

			ob_start();
			require('themes/'.THEME.'/category_pdf.tpl');
			$content = ob_get_contents();
			ob_end_clean();
			
			$html2pdf = new HTML2PDF('P','A4','nl');
  	 		$html2pdf->WriteHTML($content);
			$html2pdf->Output('category'.$id.'.pdf');
		}
	}
	
	private function createArray($type, $data){
		$data = rtrim($data, '#');
	//	print_r($data);
		$array1 = explode('#,', $data);
		$i = 0;
		foreach($array1 as $item){
			$array2 = explode('|', $item);
			$this->category[$type][$i]['name']=$array2[0];
			$this->category[$type][$i]['desc']=$array2[1];
			$this->category[$type][$i]['rate']=$array2[2];

			$this->category['total_rate'] += $this->category[$type][$i]['rate'];
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
