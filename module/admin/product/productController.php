<?php
class productController extends Controller{
	public function __construct(){
		parent::__construct();
		
		$this->authorize();
                $this->loadMenu();
                
                $this->language->load('product', $this->user['language']); //overal beschikbaar
		
		$this->label_product = $this->language->get('label_product_overview');		
		$this->label_product_name = $this->language->get('label_product_name');		
		$this->label_product_id = $this->language->get('label_product_id');		
		$this->label_product_einddatum = $this->language->get('label_product_einddatum');		
		$this->label_product_parent_id = $this->language->get('label_product_parent_id');		
		$this->label_product_edit = $this->language->get('label_product_edit');		
		$this->label_product_delete = $this->language->get('label_product_delete');		
		$this->label_product_pdf = $this->language->get('label_product_pdf');		
		$this->label_product_child = $this->language->get('label_product_child');		
		$this->label_product_text = $this->language->get('label_product_text');		
		$this->label_product_parent_choose = $this->language->get('label_product_parent_choose');		
		$this->label_product_category = $this->language->get('label_product_category');		

                $this->addScript('//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js');
                
                $this->addScript('//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js');
                
                $this->addStyle('//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css');
	}

	public function overview(){

		$this->setTitle('Overzicht products');
                
                $this->loadModel('product');
		
		$products = $this->model->getproducts();
                
                $this->products = $products;
		
                $this->render('product_overview.tpl');
	}
        
        public function treeview(){
            


                
            $this->setTitle('Tree view');
            $this->loadModel('product');
            $this->treeroot = '1'; //id 1 is the root product
            //$this->Children = $this->model->getTreetrunk();
            $this->Children = $this->model->getchildwithParent($this->treeroot);
            //$this->Children = $this->model->getParentwithChild();
            //echo "<pre>";var_dump($this->Children);echo "</pre>";
            foreach($this->Children as $child){
                
                //echo $child["product_id"];
                $this->Childs[] = $this->model->getchildwithParent($child["product_id"]);
            }
            //echo "<pre>";var_dump($this->GrandChildren[0]);echo "</pre>";
            $this->render('product_treeview.tpl');
        }
        
	public function add(){

                
		$this->setTitle('product toevoegen');
                
                $this->loadModel('product');
                
                $this->parent_category_data = $this->model->getparentcategory();
                //echo "<pre>";var_dump($this->parent_category_data);echo "</pre>";
		if($_POST){
                    
			$this->loadModel('product');

			$this->model->addproduct($_POST);
			
			$this->msg = 'product '.$_POST['req_name'].' werd toegevoegd.';
			
			$this->overview();
		}else{		
			$this->product = array(
				'name'			=> '',
				'text'			=> '',
				'parent_category_id'	=> ''
			);
			
			$this->render('product_detail.tpl');		
		}
	}

	public function edit(){

                
		$this->setTitle('product aanpassen');

		$this->loadModel('product');
                               

                
                $this->parent_category_data = $this->model->getparentcategory();
                
                //echo "<pre>";var_dump($this->product_data);echo "</pre>";
                //echo "<pre>";var_dump($this->parent_category_data);echo "</pre>";

		if($_POST){
			if($this->validate($_POST)){
				$this->model->editproduct($_POST);

				$this->msg = 'product '.$_POST['req_name'].' werd aangepast.';
			}						

			$this->overview();
		}
		
		if(isset($_GET['id'])){
			$id = $_GET['id'];
			
			$this->product = $this->model->getproduct($id);
			
                        
			$this->render('product_detail.tpl');		
		}
	}

	public function delete(){
		if(isset($_GET['id'])){
			$id = $_GET['id'];
	
			$this->loadModel('product');
			
			$product = $this->model->getproduct($id);
			
			$this->model->deleteproduct($id);
			
			$this->msg = 'U heeft product '.$product['name'].' verwijderd.';
		}
		
		$this->overview();
		//$this->redirect('index.php?route=product/overview');
	}


	public function product_pdf(){
		if(isset($_GET['id'])){
			// inladen html2pdf uit Library
			require_once('system/library/html2pdf.class.php');		

			$id = $_GET['id'];
			$this->loadModel('product');
			$this->product = $this->model->productPdf($id);
			$this->product['total_rate'] = 0;
			
			if($this->product['locations_array'] != '') $this->createArray('locations', $this->product['locations_array']);			
			if($this->product['artists_array'] != '') $this->createArray('artists', $this->product['artists_array']);
			if($this->product['resources_array'] != '') $this->createArray('resources', $this->product['resources_array']);

			ob_start();
			require('themes/'.THEME.'/product_pdf.tpl');
			$content = ob_get_contents();
			ob_end_clean();
			
			$html2pdf = new HTML2PDF('P','A4','nl');
  	 		$html2pdf->WriteHTML($content);
			$html2pdf->Output('categorie'.$id.'.pdf');
		}
	}
	
	private function createArray($type, $data){
		$data = rtrim($data, '#');
	//	print_r($data);
		$array1 = explode('#,', $data);
		$i = 0;
		foreach($array1 as $item){
			$array2 = explode('|', $item);
			$this->product[$type][$i]['name']=$array2[0];
			$this->product[$type][$i]['desc']=$array2[1];
			$this->product[$type][$i]['rate']=$array2[2];

			$this->product['total_rate'] += $this->product[$type][$i]['rate'];
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
