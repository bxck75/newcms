<?php
class categoryModel extends Model{

    
    public function getcategorys(){
            $sql = "SELECT * FROM Category";
            $result = $this->db->query($sql);
  
            return $result->rows;
    }
    public function _getcategorys(){
            //$sql = "SELECT * FROM Category";
            $r = mysql_query("SELECT * FROM Category ");
            $data = array();
            while($row = mysql_fetch_assoc($r)) {
                $data[] = $row;
            } 
            //$result = $this->db->query($sql);
  
            return $data;
    }
    
    
            

    public function deletecategory($id){
            if($id != 1){ //root can not be removed
                $sql = "DELETE FROM Category WHERE category_id = '".$this->db->escape($id)."'";		
                $this->db->query($sql);
                $sql = "DELETE FROM Category_tree WHERE category_id = '".$this->db->escape($id)."'";		
                $this->db->query($sql);

                return;
            }
    }

    public function addcategory($data){
            //var_dump($data);
            $parent_category = $data['req_parent_category'];
            $sql  = "INSERT INTO Category SET ";
            $sql .= "category_name = '".$this->db->escape($data['req_name'])."', ";
            $sql .= "category_text = '".$this->db->escape($data['req_text'])."', ";
            $sql .= "parent_id = '".$parent_category."' ;";
            echo $sql;
            $this->db->query($sql);
//            unset($sql);
//            $data['id_Cat'] = $this->db->getLastId();
//            $sql  = "INSERT INTO Category_tree SET ";
//            $sql .= "category_id = '".$data['id_Cat']."',";
//            $sql .= "parent_category_id = '".$parent_category."' ;";
//            $this->db->query($sql);
            $data['id_Tree'] = $this->db->getLastId();


            return;
    }

    public function editcategory($data){
            if($this->validatecategory($data)){
                    //handle core category data
                    $parent_category = $data['req_parent_category'];
                    $sql  = "UPDATE Category SET ";
                    $sql .= "category_name = '".$this->db->escape($data['req_name'])."', ";
                    $sql .= "category_text = '".$this->db->escape($data['req_text'])."' ";
                    $sql .= "WHERE category_id = '".$data['id']."'";
                    //echo $sql;
                    $this->db->query($sql);
//                    unset($sql);
//                    //echo "<pre>";var_dump($data);echo "</pre>";
//                    $data['id_Cat'] = $this->db->getLastId();
//                    $sql  = "UPDATE Category_tree SET ";
//                    $sql .= "parent_category_id = '".$parent_category."' ";
//                    $sql .= "WHERE category_id = '".$data['id']."' ";
//                    $sql .= "AND branch_in = '".$data['branch_in']."'; ";
//                    $this->db->query($sql);
                    //echo $sql;
                    //echo "<pre>";var_dump($data);echo "</pre>";




            }

            return;
    }

    public function getChildwithParent($parent_id){

        $sql = "SELECT * "
                ." FROM Category CT "
                ." WHERE CT.parent_id = '".$parent_id."' ;";

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