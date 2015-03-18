<?php
class Controller{
	private $title = '';
	protected $model;
	protected $error_msg = '';
	private $header_msg = '';
	public $scripts = array();
	public $styles = array();
	public $language = '';
	public $catalogus = '';

	public function __construct(){
		$this->language = new language;
	}
	
	public function index(){
		//echo 'Dit is de index van de parent controller';		
	}
	
	public function getDirs($directory, $exclude1 = '', $exclude2 = '', $exclude3 = ''){
	    $result = array_diff(scandir($directory), array('..', '.', '.DS_Store', $exclude1, $exclude2, $exclude3)); //evt andere dirs of files toevoegen die je niet wilt zien
	    return $result;
	}
	
	public function addScript($scr){
		$this->scripts[] = '<script src="'.$scr.'"></script>';
	}

	public function addStyle($style){
		$this->styles[] = '<link rel="stylesheet" href="'.$style.'">';
	}
	
	public function loadModel($module){
		if(file_exists('./module/'.STANDARD_BACKEND_MODULE_FOLDER.'/'.strtolower($module).'/'.strtolower($module).'Model.php')){
                    
			require_once('./module/'.STANDARD_BACKEND_MODULE_FOLDER.'/'.strtolower($module).'/'.strtolower($module).'Model.php');
			
			$modelName = strtolower($module).'Model';
			
			$this->model = new $modelName();
		}else{
			echo 'Kan model ./module/'.STANDARD_BACKEND_MODULE_FOLDER.'/'.strtolower($module).'/'.strtolower($module).'Model.php niet vinden';
		}
	}
	
	public function render($viewfile){
		$this->loadFile('head.tpl');
                //om data voor het menu te krijgen uit het model
                $this->HaalCatalogus();
		$this->loadFile('header.tpl');
		$this->loadFile($viewfile);
		$this->loadFile('footer.tpl');
	}
        
	public function Frontrender($viewfile){
		$this->loadFile('head.tpl');
                //om data voor het menu te krijgen uit het model
                //$this->HaalCatalogus();
		$this->loadFile('front_header.tpl');
		$this->loadFile($viewfile);
		$this->loadFile('footer.tpl');
	}
	
	public function redirect($route, $token = '', $msg = ''){
	    $str='Location: index.php?route='.$route;
		if($token != '') $str .= '&token='.$token;
		if($msg != '') $str .= '&msg='.$msg;
		// Redirect browser, $str contains location data
        header($str);
	}
	
	//functie checkt alleen of gebruiker inlogt met juiste username en password
	public function authorize(){
		if(!isset($_GET['token'])){
			$this->redirect('login', '');
		}else{
			$this->loadModel('login');
			$this->user = $this->model->authorize($_GET['token']);
			
			if($this->user){
			    //als je ingelogd bent ga je door naar de opgevraagde pagina
			    //hier extra check inbouwen op autorisatie voor die pagina!!
    			if($this->IsAuthorized($_GET['token'])){;
    			    return true;
    			}else{
    		        $this->error_msg = "U bent niet geautoriseerd voor deze pagina!!<br />";
    		        $this->error_msg .= "Maak een geldige keuze uit het menu.";
    		        $this->loadMenu();
                        $this->render("error_page.tpl");
    		        die;
    			}
			}else{
			    //user is niet ingelogd en wordt teruggestuurd naar loginpagina
			    $this->redirect('login', '', '');
			}
		}
	}
	
	public function IsAuthorized($token, $module='', $function=''){
        $this->loadModel('login');
        unset($this->msg);
        
        //eerst check op 'admin' die mag altijd alles ;-)
        $admin = $this->model->IsAdmin($token);
        if($admin){
            $this->aut_group='admin';
            //$this->msg = "Welkom admin!";
            return true;
        }
	    
        if($module!='' && $function!=''){
            $testmodule=$module;
            $testfunction=$function;
            //echo "test1";
        }elseif(isset($_GET['route']) && $_GET['route'] != ''){
            $route = explode('/', $_GET['route']);
  	        $testmodule=$route[0];
    	    $testfunction=$route[1];
    	    //echo "test2";
        }else{
            //echo "foutje?";die;
            return false;
        }
     
	    //controle autorisaties overige groepen bij user
	    //check op module en functie
        //echo "module: ".$testmodule." functie:".$testfunction;die;
        
        $result = $this->model->getAuthorization($testmodule, $token);
		//echo '<pre>'.var_dump($result).'</pre>'; die;
		      
          //check of module is toegestaan; zoniet: meteen false geven; zoja: volgende check doen
        if($result){
            //als er resultaat is, is de user geautoriseerd voor deze module; nu nog functie checken
            //$this->msg = "module ".$result['module']." is toegestaan...<br />";
          
            //check of functie is toegestaan; zoniet ook false; zoja: true
            // edit en view array vullen met functies
            $edit = array("add", "edit", "delete", "group");
            $view = array("overview", "view", "details");

            if(in_array($testfunction, $edit)){       //pagina valt onder 'edit'
                if($result["edit"]==1){
                    //$this->msg .= "edit toegestaan <br />";       //no problems
                    return true;
                }elseif($result['edit']==0){
                    //$this->msg .= "edit NIET toegestaan <br />";
                    return false;
                }
            }
            if(in_array($testfunction, $view)){       //pagina valt in categorie 'view'
                if($result['edit']==1){           //editrechten mag ook viewen
                    //$this->msg .= "edit/view toegestaan <br />";  //no problem
                    return true;
                }elseif($result['view']==1){
                    //$this->msg .= "view is toegestaan <br />"; //no problem
                    return true;
                }else{
                    //$this->msg .= "view is NIET toegestaan <br />"; 
                    return false;
                }
            }
        }else{
            //$this->msg = "module niet toegestaan";
            return false;
        }
	return true;       
    }
    	
	public function loadFile($file){
		if(file_exists('./themes/'.THEME.'/'.$file)){
			include('./themes/'.THEME.'/'.$file);
		}elseif(file_exists('./themes/default/'.$file)){
			include('./themes/default/'.$file);
		}else{
			echo 'Kan view '.$file.' niet vinden';
		}
	}
	
	public function setTitle($title){
		$this->title = APPNAME.$title;
	}
	
	// Set the header_msg to the provided text.
	public function setHeaderMSG($text){
	    $this->header_msg = $text;
	}
	
	public function loadMenu(){
            //toewijzen vertalingen menuitems
            //echo $this->user['language'];die;
            $this->language->load('menu', $this->user['language']);

            $this->menu_tree_view = $this->language->get('menu_tree_view');		
            $this->menu_tree_maker = $this->language->get('menu_tree_maker');		
            $this->menu_add_category = $this->language->get('menu_add_category');		
            $this->menu_view_category = $this->language->get('menu_view_category');		
            $this->menu_categorys = $this->language->get('menu_categorys');				
            $this->menu_usermanagement = $this->language->get('menu_usermanagement');		
            $this->menu_manage_users = $this->language->get('menu_manage_users');		
            $this->menu_manage_groups = $this->language->get('menu_manage_groups');		
            $this->menu_add_user = $this->language->get('menu_add_user');		
            $this->menu_logout = $this->language->get('menu_logout');		
            $this->text_userlogin = $this->language->get('text_userlogin');	
            $this->menu_fancy = $this->language->get('menu_fancy');	
            $this->menu_fancy_html5 = $this->language->get('menu_fancy_html5');	
            $this->menu_fancy_vectorjs = $this->language->get('menu_fancy_vectorjs');	
            $this->menu_products = $this->language->get('menu_products');	
            $this->menu_view_product = $this->language->get('menu_view_product');	
            $this->menu_add_product = $this->language->get('menu_add_product');	
	
    	 
	}
        

            
        
        public function HaalCatalogus(){
            
            $this->loadModel('category');
            
            $this->catalogus = $this->model->getcategorys();
            
                $categoryArr = Array();
                
                foreach($this->catalogus as $categoryRow){
                    //echo $categoryRow['parent_id'];
                    $this->children[$categoryRow['parent_id']] = $this->model->getChildwithParent($categoryRow['parent_id']);
                    foreach( $this->children[$categoryRow['parent_id']] as $categorychildRow){
               
                        $this->children[$categoryRow['parent_id'][$categorychildRow['parent_id']]] = $this->model->getChildwithParent($categorychildRow['parent_id']);
                    
                    }
                }

                return $this->children;
                
        }
        public function HaalProducten(){
            
            $this->loadModel('products');
            
            $this->products = $this->model->getproducts();
            
        }

}	
	
