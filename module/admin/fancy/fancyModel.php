<?php
/**
 * Description of fancymodel
 *
 * @author Boudewijnwerk
 */
class fancyModel extends model{
   
    public function getcatalogJson($links=false){
            if($links == true){
                $sql = "SELECT @i:=@i+1 as source,parent_id as target,2 as value FROM Category cross join (select @i := 0) r order by category_id limit 1,2 ";

//select name,
//      @rownum := @rownum + 1
//from your_table
//cross join (select @rownum := 0) r
//order by name


            }else{
                $sql = "SELECT category_name as name,category_id as `group` FROM Category limit 1,2";
            }
            $result = $this->db->query($sql);
            $jsonstring = json_encode($result->rows,JSON_NUMERIC_CHECK );
            return $jsonstring;
    }

}

?>
