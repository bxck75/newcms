<?php
class Model{
	public $db;
	
	public function __construct(){
		$this->db = new Db();
	}

	// Fetch the text of a Message from the table 'message' using the 'key' field.
	public function getMessageTextByKey($k)
	{
	    $sql = "SELECT text FROM message WHERE msg_key = '".$k."'";
	    $result = $this->db->query($sql);
	
	    return $result->row['text'];
	}
        public function getproductbycat($category_id){
            
            $sql = "SELECT  *  FROM Product WHERE category_id = '".$this->db->escape($category_id)."'";
            
            $result = $this->db->query($sql);
//            $row = $result->row;
//            var_dump($row);

            return $result->rows;
    }
}
