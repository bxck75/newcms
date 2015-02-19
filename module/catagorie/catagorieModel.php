<?php
class catagorieModel extends Model{
	public function getCatagories(){
		$sql = "SELECT * FROM Catagories";		
		$result = $this->db->query($sql);
		return $result->rows;
	}
	
	public function deleteCatagorie($id){
		$sql = "DELETE FROM Catagories WHERE id = '".$this->db->escape($id)."'";		
		$this->db->query($sql);
		
		return;
	}
	
	public function addCatagorie($data){
            //var_dump($data);
		$sql  = "INSERT INTO Catagories SET ";
		$sql .= "catagory_name = '".$this->db->escape($data['req_name'])."', ";
		$sql .= "parent_catagory_id = '".$data['req_parent_id']."', ";

		
		$this->db->query($sql);
		$data['id'] = $this->db->getLastId();

		
		return;
	}
	
	public function editCatagorie($data){
		if($this->validateCatagorie($data)){
			//handle core catagorie data
                        //var_dump($data);
			$sql  = "UPDATE Catagories SET ";
			$sql .= "catagory_name = '".$this->db->escape($data['req_name'])."', ";
		$sql .= "parent_catagory_id = '".$data['req_parent_id']."', ";
			
			$sql .= "WHERE id = '".$data['id']."'";
			
			$this->db->query($sql);
			
			
		}
		
		return;
	}
	
	public function getCatagorie($id){
		$sql = "SELECT * FROM Catagories WHERE id = '".$id."'";
		
		$result = $this->db->query($sql);
		
		return $result->row;
	}

	

	private function validateCatagorie($data){
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
	
	


	public function catagoriePdf($id){
		$sql = "SELECT * Catagories as ev ";
				
		
		$sql.= "WHERE id = '".$id."' ";
		$sql.= "GROUP BY id";
		
		$result = $this->db->query($sql);
		
		return $result->row;
	}


}