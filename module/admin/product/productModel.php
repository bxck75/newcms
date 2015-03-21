<?php
class productModel extends Model{

    
    public function getproducts(){
            $sql = "SELECT * FROM Product";
            $result = $this->db->query($sql);
  
            return $result->rows;
    }
    
    public function getproduct($id){
            $sql = "SELECT  *  FROM Product WHERE product_id = '".$this->db->escape($id)."'";

            $result = $this->db->query($sql);
            //$row = $result->row;
            //var_dump($row);

            return $result->row;
    }
    
    
    
            

    public function deleteproduct($id){
            if($id != 1){ //root can not be removed
                $sql = "DELETE FROM Product WHERE product_id = '".$this->db->escape($id)."'";		
                $this->db->query($sql);
                

                return;
            }
    }

    public function addproduct($data){
            
            
            $sql  = "INSERT INTO Product SET ";
            $sql .= "name = '".$this->db->escape($data['req_name'])."', ";
            $sql .= "category_id = '".$data['parent_category']."' ";
            $this->db->query($sql);
            echo $sql;
            //$data['product_id'] = $this->db->getLastId();


            return;
    }

    public function editproduct($data){
            if($this->validateproduct($data)){
                    //handle core product data
                    $parent_product = $data['req_parent_product'];
                    $sql  = "UPDATE Product SET ";
                    $sql .= "name = '".$this->db->escape($data['req_name'])."', ";
                    $sql .= "category_id = '".$data['parent_category']."' ";
                    $sql .= "WHERE product_id = '".$data['id']."'";
                    $this->db->query($sql);
                    //echo $sql;
                    //echo "<pre>";var_dump($data);echo "</pre>";
            }

            return;
    }
    
    public function getparentcategory(){
        $sql = "SELECT category_name,category_id FROM Category ";

        $result = $this->db->query($sql);

        return $result->rows;    
    }

    public function getChildwithParent($parent_id){

        $sql = "SELECT * "
                ." FROM Product CT "
                ." WHERE CT.parent_id = '".$parent_id."' ;";

        $result = $this->db->query($sql);

        return $result->rows;
    }

    private function validateproduct($data){
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




    public function productPdf($id){
            $sql = "SELECT * Catagory as ev ";


            $sql.= "WHERE product_id = '".$id."' ";
            $sql.= "GROUP BY product_id";

            $result = $this->db->query($sql);

            return $result->row;
    }


}