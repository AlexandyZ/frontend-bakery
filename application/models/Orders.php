<?php
class Orders extends CI_Model {

    // constructor
    function __construct($state=null) 
    {
        parent::__construct();
        if (is_array($state)) {
            foreach($state as $key => $value)
                $this->$key = $value;
        } elseif ($state != null) {
            $xml = simplexml_load_file($state);
            $this->number = (int) $xml->number;
            $this->datetime = (string) $xml->datetime;
            $this->items = array();
            foreach ($xml->item as $item) {
                $key = (string) $item->code;
                $quantity = (int) $item->qty;
                $this->items[$key] = $quantity;
            }
        }else {
            $this->number = 0;
            $this->datetime = null;
            $this->items = array();
        }
    }

    public function addItem($which=null) 
    {
        // ignore empty requests
        if ($which == null) return;

        // add the menu item code to our order if not already there
        if (!isset($this->items[$which]))
            $this->items[$which] = 1;
        else {
            // increment the order quantity
            $this->items[$which]++;
        }
    }

    public function updateRecipes($which=null){
        if ($which == null){
            return;
        }

        $menu = $this->recipes->get($which);
        $val = $menu->unit - 1;
        $record = array(
                   'id' => $menu->id,
                   'name' => $menu->name,
                   'description' => $menu->description,
                   'price' => $menu->price,
                   'unit' => $val
                  );
        $this->recipes->update($record);
    }

    public function receipt($which=null) 
    {
        $total = 0;
        $result = $this->data['pagetitle'] . '  ' . PHP_EOL;
        $result .= date(DATE_ATOM) . PHP_EOL;
        $result .= PHP_EOL . 'Your Order:'. PHP_EOL . PHP_EOL;
        $result .= PHP_EOL . '<h1>' . $which . '</h1>'. PHP_EOL . PHP_EOL;
        foreach($this->items as $key => $value) {
            $recipes = $this->recipes->get($key);
            $result .= '- ' . $value . ' ' . $recipes->name . PHP_EOL;
            $total += $value * $recipes->price;
        }
        $result .= PHP_EOL . 'Total: $' . number_format($total, 2) . PHP_EOL;
        return $result;
    }

    public function validate() 
    {
        // assume no items in each category
        foreach($this->recipes->all() as $id => $recipes)
            $found[$recipes->id] = false;
        // what do we have?
        /*foreach($this->items as $code => $item) {
            $menuitem = $this->recipes->get($code);
            $found[$menuitem->recipes] = true; 
        }*/
        // if any categories are empty, the order is not valid
        foreach($found as $cat => $ok)
            if (! $ok) return false;
        // phew - the order is good
        return true;
    }

    public function save() 
    {
        // figure out the order to use
        while ($this->number == 0) {
            // pick random 3 digit #
            $test = rand(100,999);
            // use this if the file doesn't exist
            if (!file_exists('../data/order'.$test.'.xml'))
                    $this->number = $test;
        }
        // and establish the checkout time
        $this->datetime = date(DATE_ATOM);

        // start empty
        $xml = new SimpleXMLElement('<order/>');
        // add the main properties
        $xml->addChild('number',$this->number);
        $xml->addChild('datetime',$this->datetime);
        foreach ($this->items as $key => $value) {
            $lineitem = $xml->addChild('item');
            $lineitem->addChild('code',$key);
            $lineitem->addChild('qty',$value);
        }
        $xml->addChild('total',$this->total());

        // save it
        $xml->asXML('../data/order' . $this->number . '.xml');
    }

    public function total() 
    {
        $total = 0;
        foreach($this->items as $key => $value) {
            $menu = $this->recipes->get($key);
            $total += $value * $menu->price;
        }
        return $total;
    }

    public function totalCostToProduce()
    {
        $total = 0;
        foreach($this->items as $key => $value) {
            $menu = $this->recipes->get($key);
            $total += $value * $menu->price * 0.8;
        }
        return $total;
    }

}