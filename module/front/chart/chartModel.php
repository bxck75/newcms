<?php

/**
 * Description of chartmodel
 *
 * @author Boudewijn
 */
class chartModel extends Model {
    //get all data for the chart
    public function getChartData(){
        $sql = "SELECT * FROM Catagories";		
        $result = $this->db->query($sql);
        return $result->rows;
    }
}
