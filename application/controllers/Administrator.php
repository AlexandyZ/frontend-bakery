<?php
/**
 * Created by PhpStorm.
 * User: kwanc
 * Date: 2016-12-04
 * Time: 7:02 PM
 */
defined('BASEPATH') OR exit('No direct script access allowed');

// Menu Model + Crud Controller
class Administrator extends Application
{
    function __construct()
    {
        parent::__construct();
        $this->load->helper('formfields_helper');
        $this->error_messages = array();
        $this->data['pagetitle'] = 'Administrator';
    }

    /**
     * Receiving Page for this controller.
     *
     * Maps to the following URL
     * http://example.com/welcome/receiving
     */
    public function index()
    {
        // Handle user-role to lock out certain types of users
        $userrole = $this->session->userdata('userrole');
        if ($userrole != 'admin') {
            $message = 'You are not authorized to access this page. Go away';
            $this->data['content'] = $message;
            $this->render();
            return;
        }

        // this is the view we want shown
        $this->data['pagebody'] = 'administrator_view';
        $this->data['supplyItems'] = $this->supplies->all();
        $this->data['recipeItems'] = $this->recipes->all();
        $this->render();
    }

    /**
     * Edit supplies based on $id
     */
    function editSupplies($id = null)
    {
        // try the session first
        $key = $this->session->userdata('key');
        $record = $this->session->userdata('record');

        if(empty($record)){
            $record = $this->supplies->get($id);
            $key = $id;
            $this->session->set_userdata('key',$id);
            $this->session->set_userdata('record',$record);
        }

        $this->data['action'] = (empty($key)) ? 'Adding' : 'Editing';
        // build the form fields
        // makeTextField (Label, database column name, record to insert)
        // disabled field => makeLaBel (Label, database column name, record to insert)
        $this->data['fid'] = makeLaBel('Item Id', 'id', $record->id);
        $this->data['fname'] = makeTextField('Item Name', 'name', $record->name);
        $this->data['fonhand'] = makeTextField('On Hand amount, units (g)', 'qty_onhand', $record->qty_onhand);
        $this->data['freceiving'] = makeTextField('Receiving amount, units (g)', 'qty_inventory', $record->qty_inventory);
        $this->data['fprice'] = makeTextField('Price ($), per unit', 'price', $record->price);

        // show the editing form
        $this->data['pagebody'] = "administrator_supplies-edit_view";
        //this is called when submit button is click ,make submit button
        $this->data['zsubmit'] = makeSubmitButton('Save', 'Submit changes');
        $this->show_any_errors();
        $this->render();
    }
    //this is called when cancel button is click, cancel the transection on editing form
    function cancel()
    {
        $this->session->unset_userdata('key');
        $this->session->unset_userdata('record');
        $this->index();
    }
    //this is called when sabe button is click, save contents on editing form to database
    function saveSupplies()
    {
        // try the session first
        $key = $this->session->userdata('key');
        $record = $this->session->userdata('record');
        // if not there, nothing is in progress
        if (empty($record)) {
            $this->index();
            return;
        }

        // update our data transfer object
        $incoming = $this->input->post();
        foreach(get_object_vars($record) as $key=> $value)
            if (isset($incoming[$key]))
                $record->$key = $incoming[$key];
        $this->session->set_userdata('record',$record);

        // validate
        $this->load->library('form_validation');
        $this->form_validation->set_rules($this->supplies->adminSupplyRules());
        if ($this->form_validation->run() != TRUE)
            $this->error_messages = $this->form_validation->error_array();

        // check menu code for additions
        if ($key == null)
            if ($this->supplies->exists($record->id))
                $this->error_messages[] = 'Duplicate id adding new menu item';

        // save or not
        if (! empty($this->error_messages)) {
            $this->editSupplies();
            return;
        }

        // update our table, finally!
        if ($key == null)
            $this->supplies->add($record);
        else
            $this->supplies->update($record);
        $this->session->unset_userdata('key');
   		$this->session->unset_userdata('record');
        // and redisplay the list
        $this->index();
    }
    //show error of fields form
    function show_any_errors() {
        $result = '';
        if (empty($this->error_messages)) {
            $this->data['error_messages'] = '';
            return;
        }
        // add the error messages to a single string with breaks
        foreach($this->error_messages as $onemessage)
            $result .= $onemessage . '<br/>';
        // and wrap these per our view fragment
        $this->data['error_messages'] = $this->parser->parse('mtce-errors',
            ['error_messages' => $result], true);
    }
    //this is called when delete button is click, delete items from database
    function delete() {
        $key = $this->session->userdata('key');
        $record = $this->session->userdata('record');
        // only delete if editing an existing record
        if (! empty($record)) {
            $this->supplies->delete($key);
        }
        $this->index();
    }
}