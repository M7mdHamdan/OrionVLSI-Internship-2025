class ALU_Agent extends uvm_agent;

    ALU_Sequencer sequencer;
    ALU_Driver driver;
    ALU_Monitor monitor;

    `uvm_component_utils(ALU_Agent)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(get_is_active() == UVM_ACTIVE) begin
            sequencer = ALU_Sequencer::type_id::create("ALU_sequencer",this);
            driver = ALU_Driver::type_id::create("ALU_driver",this);
        end
        monitor = ALU_Monitor::type_id::create("ALU_monitor",this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        if(get_is_active() == UVM_ACTIVE)begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction


endclass