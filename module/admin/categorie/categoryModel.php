<?php
class categoryModel extends Model{
	public function getcategorys(){
		$sql = "SELECT * FROM Category";		
		$result = $this->db->query($sql);
		return $result->rows;
	}
	
	public function deletecategory($id){
		if($id != 1){ //root can not be removed
                    $sql = "DELETE FROM Category WHERE category_id = '".$this->db->escape($id)."'";		
                    $this->db->query($sql);
		
                    return;
                }
	}
	
	public function addcategory($data){
            
		$sql  = "INSERT INTO Category SET ";
		$sql .= "category_name = '".$this->db->escape($data['req_name'])."', ";
		$sql .= "category_text = '".$data['req_category_text']."' ";
                $this->db->query($sql);
		$data['id'] = $this->db->getLastId();

		
		return;
	}
	
	public function editcategory($data){
		if($this->validatecategory($data)){
			//handle core category data
                        //var_dump($data);
			$sql  = "UPDATE Category SET ";
			$sql .= "category_name = '".$this->db->escape($data['category_name'])."', ";
                        $sql .= "category_text = '".$data['category_text']."' ";
			$sql .= "WHERE category_id = '".$data['id']."'";
			//echo $sql;
			$this->db->query($sql);
			
			
		}
		
		return;
	}
	public function getCategorieChilds($id){
            $sql = "SELECT * FROM Category_tree WHERE category_id =".$id;
            $result = $this->db->query($sql);
            return $result->rows;
            
        }
        
	public function getcategory($id){
		$sql = "SELECT  *  FROM Category WHERE category_id = '".$this->db->escape($id)."'";
		
		$result = $this->db->query($sql);
                //$row = $result->row;
                //var_dump($row);
		
		return $result->row;
	}

	

	private function validatecategory($data){
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
	
	


	public function categoryPdf($id){
		$sql = "SELECT * Catagory as ev ";
				
		
		$sql.= "WHERE category_id = '".$id."' ";
		$sql.= "GROUP BY category_id";
		
		$result = $this->db->query($sql);
		
		return $result->row;
	}


}