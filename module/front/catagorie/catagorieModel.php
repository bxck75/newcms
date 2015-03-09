<?php
class categoryModel extends Model{
	public function getcategorys(){
		$sql = "SELECT * FROM categorys";		
		$result = $this->db->query($sql);
		return $result->rows;
	}
	
	public function deletecategory($id){
		$sql = "DELETE FROM categorys WHERE categorie_id = '".$this->db->escape($id)."'";		
		$this->db->query($sql);
		
		return;
	}
	
	public function addcategory($data){
            //var_dump($data);
		$sql  = "INSERT INTO categorys SET ";
		$sql .= "catagory_name = '".$this->db->escape($data['req_name'])."', ";
		$sql .= "parent_catagory_id = '".$data['req_parent_id']."', ";

		
		$this->db->query($sql);
		$data['id'] = $this->db->getLastId();

		
		return;
	}
	
	public function editcategory($data){
		if($this->validatecategory($data)){
			//handle core category data
                        //var_dump($data);
			$sql  = "UPDATE categorys SET ";
			$sql .= "catagory_name = '".$this->db->escape($data['req_name'])."', ";
		$sql .= "parent_catagory_id = '".$data['req_parent_id']."', ";
			
			$sql .= "WHERE id = '".$data['id']."'";
			
			$this->db->query($sql);
			
			
		}
		
		return;
	}
	
	public function getcategory($id){
		$sql = "SELECT * FROM categorys WHERE id = '".$id."'";
		
		$result = $this->db->query($sql);
		
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
		$sql = "SELECT * categorys as ev ";
				
		
		$sql.= "WHERE id = '".$id."' ";
		$sql.= "GROUP BY id";
		
		$result = $this->db->query($sql);
		
		return $result->row;
	}


}