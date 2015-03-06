<?php
class catagorieModel extends Model{
	public function getCatagories(){
		$sql = "SELECT * FROM Catagories";		
		$result = $this->db->query($sql);
		return $result->rows;
	}
	
	public function deleteCatagorie($id){
		if($id != 1){ //root can not be removed
                    $sql = "DELETE FROM Catagories WHERE category_id = '".$this->db->escape($id)."'";		
                    $this->db->query($sql);
		
                    return;
                }
	}
	
	public function addCatagorie($data){
            
		$sql  = "INSERT INTO Catagories SET ";
		$sql .= "category_name = '".$this->db->escape($data['req_name'])."', ";
		$sql .= "parent_category_id = '".$data['reqnum_parent_id']."' ";
                $this->db->query($sql);
		$data['id'] = $this->db->getLastId();

		
		return;
	}
	
	public function editCatagorie($data){
		if($this->validateCatagorie($data)){
			//handle core catagorie data
                        //var_dump($data);
			$sql  = "UPDATE Catagories SET ";
			$sql .= "category_name = '".$this->db->escape($data['req_name'])."', ";
                        $sql .= "parent_category_id = '".$data['reqnum_parent_id']."' ";
			$sql .= "WHERE category_id = '".$data['id']."'";
			//echo $sql;
			$this->db->query($sql);
			
			
		}
		
		return;
	}
	public function getCategorieChilds($id){
            $sql = "SELECT * FROM Catagories WHERE parent_category_id =".$id;
            $result = $this->db->query($sql);
            return $result->rows;
        }
        
	public function getCatagorie($id){
		$sql = "SELECT "
                            ." * " 
                            //."C1.category_id, "
                            //."C1.category_name, "
                            //."C1.parent_category_id, "
                            //."C2.category_id as child_category_id, "
                            //."C2.category_name as child_category_name, "
                            //."C2.parent_category_id as child_parent_category_id "
                            ." FROM Catagories C1 "
                            //." LEFT JOIN Catagories C2 on C1.parent_category_id = C2.category_id"
                            ." WHERE C1.category_id = '".$this->db->escape($id)."'";
		
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
		$sql.= "GROUP BY category_id";
		
		$result = $this->db->query($sql);
		
		return $result->row;
	}


}