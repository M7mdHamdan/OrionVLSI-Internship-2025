class ALU_Monitor extends uvm_monitor;
    virtual ALU_Interface vif;

    uvm_analysis_port #(ALU_SequenceItem) port;
    ALU_SequenceItem packet;

    `uvm_component_utils(ALU_Monitor)

    function new (string name, uvm_component parent);
        super.new(name, parent);
        port = new("monitor_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ALU_Interface) :: get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Not set at top level");
    endfunction
    

    task run_phase(uvm_phase phase);
    forever begin
        @(vif.MONITOR_CB);
        packet = ALU_SequenceItem::type_id::create("packet", this);
        packet.A = vif.MONITOR_CB.A;
        packet.B = vif.MONITOR_CB.B;
        packet.Opcode = vif.MONITOR_CB.Opcode;
        `uvm_info(get_type_name(), $sformatf("Monitor: input signals are 
            sent to the DUT are:
            A = %0d, B = %0d, Opcode = %h", packet.A, packet.B,packet.Opcode), 	UVM_HIGH);
        packet.Result = vif.MONITOR_CB.Result;
        packet.Error = vif.MONITOR_CB.Error;
        `uvm_info(get_type_name(), $sformatf("Monitor: the output signals
            received from the DUT are:
            Result = %d, Error = %b",packet.Result,packet.Error), UVM_HIGH);
        port.write(packet);
    end
endtask
    
endclass
