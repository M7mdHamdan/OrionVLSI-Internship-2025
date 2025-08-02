class ALU_Driver extends uvm_driver #(ALU_SequenceItem);

    virtual ALU_Interface vif;
    `uvm_component_utils(ALU_Driver)
    ALU_SequenceItem req;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task drive();
        @(vif.DRIVER_CB);
        vif.DRIVER_CB.A <= req.A;
        vif.DRIVER_CB.B <= req.B;
        vif.DRIVER_CB.Opcode <= req.Opcode;
    endtask

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ALU_Interface)::get(this,"","vif",vif))
            `uvm_fatal(get_type_name(), "Not set at top level");
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            drive();
            `uvm_info(get_type_name(), $sformatf(
                "Driver: signals driven to the DUT are: 
                A= %0d, B= %0d, Opcode = %h", req.A, req.B, req.Opcode),
                 UVM_HIGH)
            seq_item_port.item_done();
        end
    endtask; 
endclass