namespace ConsoleApplication2
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class Model1 : DbContext
    {
        public Model1()
            : base("name=PortalDB")
        {
        }

        public virtual DbSet<AlarmsStatusData> AlarmsStatusDatas { get; set; }
        public virtual DbSet<AnalysisEvent> AnalysisEvents { get; set; }
        public virtual DbSet<AnalysisTime> AnalysisTimes { get; set; }
        public virtual DbSet<ApplicationSetting> ApplicationSettings { get; set; }
        public virtual DbSet<AuditLogData> AuditLogDatas { get; set; }
        public virtual DbSet<cfgValuesFactory> cfgValuesFactories { get; set; }
        public virtual DbSet<cfgValuesGlobal> cfgValuesGlobals { get; set; }
        public virtual DbSet<cfgValuesPatient> cfgValuesPatients { get; set; }
        public virtual DbSet<cfgValuesUnit> cfgValuesUnits { get; set; }
        public virtual DbSet<ChannelInfoData> ChannelInfoDatas { get; set; }
        public virtual DbSet<DeviceInfoData> DeviceInfoDatas { get; set; }
        public virtual DbSet<DeviceSession> DeviceSessions { get; set; }
        public virtual DbSet<Enum> Enums { get; set; }
        public virtual DbSet<EventsData> EventsDatas { get; set; }
        public virtual DbSet<GdsCodeMap> GdsCodeMaps { get; set; }
        public virtual DbSet<GeneralAlarmsData> GeneralAlarmsDatas { get; set; }
        public virtual DbSet<gts_input_rate> gts_input_rate { get; set; }
        public virtual DbSet<gts_waveform_index_rate> gts_waveform_index_rate { get; set; }
        public virtual DbSet<HL7InboundMessage> HL7InboundMessage { get; set; }
        public virtual DbSet<int_12lead_report> int_12lead_report { get; set; }
        public virtual DbSet<int_12lead_report_new> int_12lead_report_new { get; set; }
        public virtual DbSet<int_alarm> int_alarm { get; set; }
        public virtual DbSet<int_beat_time_log> int_beat_time_log { get; set; }
        public virtual DbSet<int_bin_info> int_bin_info { get; set; }
        public virtual DbSet<int_cfg_values> int_cfg_values { get; set; }
        public virtual DbSet<int_misc_code> int_misc_code { get; set; }
        public virtual DbSet<int_print_job> int_print_job { get; set; }
        public virtual DbSet<int_print_job_et_alarm> int_print_job_et_alarm { get; set; }
        public virtual DbSet<int_print_job_et_vitals> int_print_job_et_vitals { get; set; }
        public virtual DbSet<int_print_job_et_waveform> int_print_job_et_waveform { get; set; }
        public virtual DbSet<int_print_job_waveform> int_print_job_waveform { get; set; }
        public virtual DbSet<int_result> int_result { get; set; }
        public virtual DbSet<int_SavedEvent> int_SavedEvent { get; set; }
        public virtual DbSet<int_savedevent_beat_time_log> int_savedevent_beat_time_log { get; set; }
        public virtual DbSet<int_savedevent_calipers> int_savedevent_calipers { get; set; }
        public virtual DbSet<int_savedevent_vitals> int_savedevent_vitals { get; set; }
        public virtual DbSet<int_SavedEvent_Waveform> int_SavedEvent_Waveform { get; set; }
        public virtual DbSet<int_template_set_info> int_template_set_info { get; set; }
        public virtual DbSet<int_user> int_user { get; set; }
        public virtual DbSet<LeadConfiguration> LeadConfigurations { get; set; }
        public virtual DbSet<LimitAlarmsData> LimitAlarmsDatas { get; set; }
        public virtual DbSet<LimitChangeData> LimitChangeDatas { get; set; }
        public virtual DbSet<LiveData> LiveDatas { get; set; }
        public virtual DbSet<LogData> LogDatas { get; set; }
        public virtual DbSet<MetaData> MetaDatas { get; set; }
        public virtual DbSet<ml_duplicate_info> ml_duplicate_info { get; set; }
        public virtual DbSet<PacerSpikeLog> PacerSpikeLogs { get; set; }
        public virtual DbSet<PatientData> PatientDatas { get; set; }
        public virtual DbSet<PatientSession> PatientSessions { get; set; }
        public virtual DbSet<PatientSessionsMap> PatientSessionsMaps { get; set; }
        public virtual DbSet<PrintRequestDescription> PrintRequestDescriptions { get; set; }
        public virtual DbSet<RemovedAlarm> RemovedAlarms { get; set; }
        public virtual DbSet<ResourceString> ResourceStrings { get; set; }
        public virtual DbSet<StatusData> StatusDatas { get; set; }
        public virtual DbSet<StatusDataSet> StatusDataSets { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
        public virtual DbSet<tbl_ConfigurationData> tbl_ConfigurationData { get; set; }
        public virtual DbSet<TopicFeedType> TopicFeedTypes { get; set; }
        public virtual DbSet<TopicSession> TopicSessions { get; set; }
        public virtual DbSet<TopicType> TopicTypes { get; set; }
        public virtual DbSet<TrendData> TrendDatas { get; set; }
        public virtual DbSet<VitalsData> VitalsDatas { get; set; }
        public virtual DbSet<WaveformData> WaveformDatas { get; set; }
        public virtual DbSet<WaveformLiveData> WaveformLiveDatas { get; set; }
        public virtual DbSet<cdr_navigation_button> cdr_navigation_button { get; set; }
        public virtual DbSet<cdr_restricted_organization> cdr_restricted_organization { get; set; }
        public virtual DbSet<Device> Devices { get; set; }
        public virtual DbSet<hl7_in_qhist> hl7_in_qhist { get; set; }
        public virtual DbSet<hl7_in_queue> hl7_in_queue { get; set; }
        public virtual DbSet<hl7_msg_ack> hl7_msg_ack { get; set; }
        public virtual DbSet<hl7_msg_list> hl7_msg_list { get; set; }
        public virtual DbSet<hl7_out_queue> hl7_out_queue { get; set; }
        public virtual DbSet<HL7PatientLink> HL7PatientLink { get; set; }
        public virtual DbSet<int_12lead_report_edit> int_12lead_report_edit { get; set; }
        public virtual DbSet<int_account> int_account { get; set; }
        public virtual DbSet<int_address> int_address { get; set; }
        public virtual DbSet<int_alarm_retrieved> int_alarm_retrieved { get; set; }
        public virtual DbSet<int_alarm_waveform> int_alarm_waveform { get; set; }
        public virtual DbSet<int_allergy> int_allergy { get; set; }
        public virtual DbSet<int_audit_log> int_audit_log { get; set; }
        public virtual DbSet<int_autoupdate> int_autoupdate { get; set; }
        public virtual DbSet<int_autoupdate_log> int_autoupdate_log { get; set; }
        public virtual DbSet<int_channel_type> int_channel_type { get; set; }
        public virtual DbSet<int_channel_vital> int_channel_vital { get; set; }
        public virtual DbSet<int_client_map> int_client_map { get; set; }
        public virtual DbSet<int_cmtry_report> int_cmtry_report { get; set; }
        public virtual DbSet<int_code_category> int_code_category { get; set; }
        public virtual DbSet<int_db_ver> int_db_ver { get; set; }
        public virtual DbSet<int_diagnosis> int_diagnosis { get; set; }
        public virtual DbSet<int_diagnosis_drg> int_diagnosis_drg { get; set; }
        public virtual DbSet<int_diagnosis_hcp_int> int_diagnosis_hcp_int { get; set; }
        public virtual DbSet<int_encounter> int_encounter { get; set; }
        public virtual DbSet<int_encounter_map> int_encounter_map { get; set; }
        public virtual DbSet<int_encounter_tfr_history> int_encounter_tfr_history { get; set; }
        public virtual DbSet<int_encounter_to_hcp_int> int_encounter_to_hcp_int { get; set; }
        public virtual DbSet<int_environment> int_environment { get; set; }
        public virtual DbSet<int_event_config> int_event_config { get; set; }
        public virtual DbSet<int_event_log> int_event_log { get; set; }
        public virtual DbSet<int_external_organization> int_external_organization { get; set; }
        public virtual DbSet<int_feature> int_feature { get; set; }
        public virtual DbSet<int_flowsheet> int_flowsheet { get; set; }
        public virtual DbSet<int_gateway> int_gateway { get; set; }
        public virtual DbSet<int_gateway_server> int_gateway_server { get; set; }
        public virtual DbSet<int_guarantor> int_guarantor { get; set; }
        public virtual DbSet<int_hcp> int_hcp { get; set; }
        public virtual DbSet<int_hcp_contact> int_hcp_contact { get; set; }
        public virtual DbSet<int_hcp_license> int_hcp_license { get; set; }
        public virtual DbSet<int_hcp_map> int_hcp_map { get; set; }
        public virtual DbSet<int_hcp_specialty> int_hcp_specialty { get; set; }
        public virtual DbSet<int_insurance_plan> int_insurance_plan { get; set; }
        public virtual DbSet<int_insurance_policy> int_insurance_policy { get; set; }
        public virtual DbSet<int_loader_stats> int_loader_stats { get; set; }
        public virtual DbSet<int_mon_request> int_mon_request { get; set; }
        public virtual DbSet<int_monitor> int_monitor { get; set; }
        public virtual DbSet<int_mrn_map> int_mrn_map { get; set; }
        public virtual DbSet<int_msg_log> int_msg_log { get; set; }
        public virtual DbSet<int_msg_template> int_msg_template { get; set; }
        public virtual DbSet<int_nok> int_nok { get; set; }
        public virtual DbSet<int_nxt_ascending_key> int_nxt_ascending_key { get; set; }
        public virtual DbSet<int_nxt_descending_key> int_nxt_descending_key { get; set; }
        public virtual DbSet<int_order> int_order { get; set; }
        public virtual DbSet<int_order_group> int_order_group { get; set; }
        public virtual DbSet<int_order_group_detail> int_order_group_detail { get; set; }
        public virtual DbSet<int_order_line> int_order_line { get; set; }
        public virtual DbSet<int_order_map> int_order_map { get; set; }
        public virtual DbSet<int_org_shift_sched> int_org_shift_sched { get; set; }
        public virtual DbSet<int_organization> int_organization { get; set; }
        public virtual DbSet<int_outbound_queue> int_outbound_queue { get; set; }
        public virtual DbSet<int_param_timetag> int_param_timetag { get; set; }
        public virtual DbSet<int_patient> int_patient { get; set; }
        public virtual DbSet<int_patient_channel> int_patient_channel { get; set; }
        public virtual DbSet<int_patient_document> int_patient_document { get; set; }
        public virtual DbSet<int_patient_image> int_patient_image { get; set; }
        public virtual DbSet<int_patient_link> int_patient_link { get; set; }
        public virtual DbSet<int_patient_list> int_patient_list { get; set; }
        public virtual DbSet<int_patient_list_detail> int_patient_list_detail { get; set; }
        public virtual DbSet<int_patient_list_link> int_patient_list_link { get; set; }
        public virtual DbSet<int_patient_monitor> int_patient_monitor { get; set; }
        public virtual DbSet<int_patient_procedure> int_patient_procedure { get; set; }
        public virtual DbSet<int_person> int_person { get; set; }
        public virtual DbSet<int_person_name> int_person_name { get; set; }
        public virtual DbSet<int_pref> int_pref { get; set; }
        public virtual DbSet<int_pref_diff> int_pref_diff { get; set; }
        public virtual DbSet<int_pref_lock> int_pref_lock { get; set; }
        public virtual DbSet<int_pref_pushdown> int_pref_pushdown { get; set; }
        public virtual DbSet<int_procedure> int_procedure { get; set; }
        public virtual DbSet<int_procedure_hcp_int> int_procedure_hcp_int { get; set; }
        public virtual DbSet<int_product> int_product { get; set; }
        public virtual DbSet<int_product_access> int_product_access { get; set; }
        public virtual DbSet<int_product_map> int_product_map { get; set; }
        public virtual DbSet<int_reference_range> int_reference_range { get; set; }
        public virtual DbSet<int_result_flag> int_result_flag { get; set; }
        public virtual DbSet<int_saved_event> int_saved_event { get; set; }
        public virtual DbSet<int_saved_event_waveform> int_saved_event_waveform { get; set; }
        public virtual DbSet<int_savedevent_event_log> int_savedevent_event_log { get; set; }
        public virtual DbSet<int_security> int_security { get; set; }
        public virtual DbSet<int_security_diff> int_security_diff { get; set; }
        public virtual DbSet<int_security_lock> int_security_lock { get; set; }
        public virtual DbSet<int_security_pushdown> int_security_pushdown { get; set; }
        public virtual DbSet<int_send_sys> int_send_sys { get; set; }
        public virtual DbSet<int_site_link> int_site_link { get; set; }
        public virtual DbSet<int_specimen> int_specimen { get; set; }
        public virtual DbSet<int_specimen_group> int_specimen_group { get; set; }
        public virtual DbSet<int_sysgen> int_sysgen { get; set; }
        public virtual DbSet<int_sysgen_audit> int_sysgen_audit { get; set; }
        public virtual DbSet<int_sysgen_comment> int_sysgen_comment { get; set; }
        public virtual DbSet<int_system_parameter> int_system_parameter { get; set; }
        public virtual DbSet<int_tech_map> int_tech_map { get; set; }
        public virtual DbSet<int_telephone> int_telephone { get; set; }
        public virtual DbSet<int_test_group> int_test_group { get; set; }
        public virtual DbSet<int_test_group_detail> int_test_group_detail { get; set; }
        public virtual DbSet<int_translate> int_translate { get; set; }
        public virtual DbSet<int_translate_list> int_translate_list { get; set; }
        public virtual DbSet<int_user_contact> int_user_contact { get; set; }
        public virtual DbSet<int_user_group> int_user_group { get; set; }
        public virtual DbSet<int_user_group_member> int_user_group_member { get; set; }
        public virtual DbSet<int_user_password> int_user_password { get; set; }
        public virtual DbSet<int_user_role> int_user_role { get; set; }
        public virtual DbSet<int_user_settings> int_user_settings { get; set; }
        public virtual DbSet<int_vital_live> int_vital_live { get; set; }
        public virtual DbSet<int_vital_live_temp> int_vital_live_temp { get; set; }
        public virtual DbSet<int_waveform> int_waveform { get; set; }
        public virtual DbSet<int_waveform_live> int_waveform_live { get; set; }
        public virtual DbSet<mpi_decision_field> mpi_decision_field { get; set; }
        public virtual DbSet<mpi_decision_log> mpi_decision_log { get; set; }
        public virtual DbSet<mpi_decision_queue> mpi_decision_queue { get; set; }
        public virtual DbSet<mpi_patient_link> mpi_patient_link { get; set; }
        public virtual DbSet<mpi_search_field> mpi_search_field { get; set; }
        public virtual DbSet<PrintBlobData> PrintBlobDatas { get; set; }
        public virtual DbSet<PrintJob> PrintJobs { get; set; }
        public virtual DbSet<PrintRequestData> PrintRequestDatas { get; set; }
        public virtual DbSet<PrintRequest> PrintRequests { get; set; }
        public virtual DbSet<WaveformAnnotationData> WaveformAnnotationDatas { get; set; }
        public virtual DbSet<WaveformPrintData> WaveformPrintDatas { get; set; }
        public virtual DbSet<v_ActivePatientChannels> v_ActivePatientChannels { get; set; }
        public virtual DbSet<v_AvailableDataTypes> v_AvailableDataTypes { get; set; }
        public virtual DbSet<v_CombinedEncounters> v_CombinedEncounters { get; set; }
        public virtual DbSet<v_DevicePatientIdActive> v_DevicePatientIdActive { get; set; }
        public virtual DbSet<v_DeviceSessionAssignment> v_DeviceSessionAssignment { get; set; }
        public virtual DbSet<v_DeviceSessionInfo> v_DeviceSessionInfo { get; set; }
        public virtual DbSet<v_DeviceSessionOrganization> v_DeviceSessionOrganization { get; set; }
        public virtual DbSet<v_DiscardedOverlappingLegacyWaveformData> v_DiscardedOverlappingLegacyWaveformData { get; set; }
        public virtual DbSet<v_DiscardedOverlappingWaveformData> v_DiscardedOverlappingWaveformData { get; set; }
        public virtual DbSet<v_FeedGdsCodes> v_FeedGdsCodes { get; set; }
        public virtual DbSet<v_GeneralAlarms> v_GeneralAlarms { get; set; }
        public virtual DbSet<v_GeneralAlarmsLite> v_GeneralAlarmsLite { get; set; }
        public virtual DbSet<v_LegacyChannelTypes> v_LegacyChannelTypes { get; set; }
        public virtual DbSet<v_LegacyMonitor> v_LegacyMonitor { get; set; }
        public virtual DbSet<v_LegacyMonitorCombined> v_LegacyMonitorCombined { get; set; }
        public virtual DbSet<v_LegacyPatientMonitor> v_LegacyPatientMonitor { get; set; }
        public virtual DbSet<v_LegacyPatientMonitorCombined> v_LegacyPatientMonitorCombined { get; set; }
        public virtual DbSet<v_LegacyWaveform> v_LegacyWaveform { get; set; }
        public virtual DbSet<v_LimitAlarms> v_LimitAlarms { get; set; }
        public virtual DbSet<v_LimitAlarmsLite> v_LimitAlarmsLite { get; set; }
        public virtual DbSet<v_LiveVitalsData> v_LiveVitalsData { get; set; }
        public virtual DbSet<v_MetaData> v_MetaData { get; set; }
        public virtual DbSet<v_Monitors> v_Monitors { get; set; }
        public virtual DbSet<v_PatientChannelLegacy> v_PatientChannelLegacy { get; set; }
        public virtual DbSet<v_Patients> v_Patients { get; set; }
        public virtual DbSet<v_PatientSessionOrganization> v_PatientSessionOrganization { get; set; }
        public virtual DbSet<v_PatientSessions> v_PatientSessions { get; set; }
        public virtual DbSet<v_PatientTopicSessions> v_PatientTopicSessions { get; set; }
        public virtual DbSet<v_PrintJobs> v_PrintJobs { get; set; }
        public virtual DbSet<v_PrintJobsWaveform> v_PrintJobsWaveform { get; set; }
        public virtual DbSet<v_StatusData> v_StatusData { get; set; }
        public virtual DbSet<v_StitchedPatients> v_StitchedPatients { get; set; }
        public virtual DbSet<v_TopicTypes> v_TopicTypes { get; set; }
        public virtual DbSet<v_VitalsData> v_VitalsData { get; set; }
        public virtual DbSet<v_WaveformSampleRate> v_WaveformSampleRate { get; set; }
        public virtual DbSet<vwMetaDataValueNum> vwMetaDataValueNums { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AnalysisTime>()
                .HasMany(e => e.AnalysisEvents)
                .WithRequired(e => e.AnalysisTime)
                .HasForeignKey(e => new { e.user_id, e.patient_id });

            modelBuilder.Entity<AnalysisTime>()
                .HasMany(e => e.int_beat_time_log)
                .WithRequired(e => e.AnalysisTime)
                .HasForeignKey(e => new { e.user_id, e.patient_id });

            modelBuilder.Entity<AnalysisTime>()
                .HasMany(e => e.int_template_set_info)
                .WithRequired(e => e.AnalysisTime)
                .HasForeignKey(e => new { e.user_id, e.patient_id });

            modelBuilder.Entity<AnalysisTime>()
                .HasMany(e => e.PacerSpikeLogs)
                .WithRequired(e => e.AnalysisTime)
                .HasForeignKey(e => new { e.user_id, e.patient_id });

            modelBuilder.Entity<AnalysisTime>()
                .HasOptional(e => e.TrendData)
                .WithRequired(e => e.AnalysisTime)
                .WillCascadeOnDelete();

            modelBuilder.Entity<ApplicationSetting>()
                .Property(e => e.ApplicationType)
                .IsUnicode(false);

            modelBuilder.Entity<ApplicationSetting>()
                .Property(e => e.InstanceId)
                .IsUnicode(false);

            modelBuilder.Entity<ApplicationSetting>()
                .Property(e => e.Key)
                .IsUnicode(false);

            modelBuilder.Entity<ApplicationSetting>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<AuditLogData>()
                .Property(e => e.PatientID)
                .IsUnicode(false);

            modelBuilder.Entity<AuditLogData>()
                .Property(e => e.HashedValue)
                .IsFixedLength();

            modelBuilder.Entity<cfgValuesFactory>()
                .Property(e => e.type_cd)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesFactory>()
                .Property(e => e.cfg_name)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesFactory>()
                .Property(e => e.value_type)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesGlobal>()
                .Property(e => e.type_cd)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesGlobal>()
                .Property(e => e.cfg_name)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesGlobal>()
                .Property(e => e.value_type)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesPatient>()
                .Property(e => e.type_cd)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesPatient>()
                .Property(e => e.cfg_name)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesPatient>()
                .Property(e => e.value_type)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesUnit>()
                .Property(e => e.type_cd)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesUnit>()
                .Property(e => e.cfg_name)
                .IsUnicode(false);

            modelBuilder.Entity<cfgValuesUnit>()
                .Property(e => e.value_type)
                .IsUnicode(false);

            modelBuilder.Entity<DeviceInfoData>()
                .Property(e => e.Name)
                .IsFixedLength();

            modelBuilder.Entity<DeviceInfoData>()
                .Property(e => e.Value)
                .IsFixedLength();

            modelBuilder.Entity<Enum>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<Enum>()
                .Property(e => e.GroupName)
                .IsUnicode(false);

            modelBuilder.Entity<GdsCodeMap>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<GdsCodeMap>()
                .Property(e => e.GdsCode)
                .IsUnicode(false);

            modelBuilder.Entity<GdsCodeMap>()
                .Property(e => e.Units)
                .IsUnicode(false);

            modelBuilder.Entity<gts_input_rate>()
                .Property(e => e.input_type)
                .IsUnicode(false);

            modelBuilder.Entity<HL7InboundMessage>()
                .Property(e => e.MessageStatus)
                .IsFixedLength();

            modelBuilder.Entity<HL7InboundMessage>()
                .Property(e => e.MessageType)
                .IsFixedLength();

            modelBuilder.Entity<HL7InboundMessage>()
                .Property(e => e.MessageTypeEventCode)
                .IsFixedLength();

            modelBuilder.Entity<HL7InboundMessage>()
                .HasMany(e => e.HL7PatientLink)
                .WithRequired(e => e.HL7InboundMessage)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<int_12lead_report>()
                .HasOptional(e => e.int_12lead_report_new)
                .WithRequired(e => e.int_12lead_report)
                .WillCascadeOnDelete();

            modelBuilder.Entity<int_alarm>()
                .Property(e => e.is_stacked)
                .IsUnicode(false);

            modelBuilder.Entity<int_alarm>()
                .Property(e => e.is_level_changed)
                .IsUnicode(false);

            modelBuilder.Entity<int_cfg_values>()
                .Property(e => e.keyname)
                .IsUnicode(false);

            modelBuilder.Entity<int_cfg_values>()
                .Property(e => e.keyvalue)
                .IsUnicode(false);

            modelBuilder.Entity<int_misc_code>()
                .Property(e => e.category_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_misc_code>()
                .Property(e => e.spc_pcs_code)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.job_type)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.title)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.bed)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.recording_time)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.annotation1)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.annotation2)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.annotation3)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.annotation4)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.printer_name)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.status_code)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job>()
                .Property(e => e.status_msg)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job_et_vitals>()
                .Property(e => e.GDSCode)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job_et_waveform>()
                .Property(e => e.CdiLabel)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job_waveform>()
                .Property(e => e.waveform_type)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job_waveform>()
                .Property(e => e.channel_type)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job_waveform>()
                .Property(e => e.primary_annotation)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job_waveform>()
                .Property(e => e.secondary_annotation)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job_waveform>()
                .Property(e => e.waveform_data)
                .IsUnicode(false);

            modelBuilder.Entity<int_print_job_waveform>()
                .Property(e => e.scale_labels)
                .IsUnicode(false);

            modelBuilder.Entity<int_SavedEvent>()
                .HasOptional(e => e.int_savedevent_beat_time_log)
                .WithRequired(e => e.int_SavedEvent)
                .WillCascadeOnDelete();

            modelBuilder.Entity<int_SavedEvent>()
                .HasMany(e => e.int_savedevent_calipers)
                .WithRequired(e => e.int_SavedEvent)
                .HasForeignKey(e => new { e.patient_id, e.event_id });

            modelBuilder.Entity<int_SavedEvent>()
                .HasMany(e => e.int_savedevent_event_log)
                .WithRequired(e => e.int_SavedEvent)
                .HasForeignKey(e => new { e.patient_id, e.event_id });

            modelBuilder.Entity<int_SavedEvent>()
                .HasMany(e => e.int_savedevent_vitals)
                .WithRequired(e => e.int_SavedEvent)
                .HasForeignKey(e => new { e.patient_id, e.event_id });

            modelBuilder.Entity<int_SavedEvent>()
                .HasMany(e => e.int_SavedEvent_Waveform)
                .WithRequired(e => e.int_SavedEvent)
                .HasForeignKey(e => new { e.patient_id, e.event_id });

            modelBuilder.Entity<int_savedevent_calipers>()
                .Property(e => e.calipers_orientation)
                .IsFixedLength();

            modelBuilder.Entity<int_SavedEvent_Waveform>()
                .Property(e => e.waveform_color)
                .IsUnicode(false);

            modelBuilder.Entity<int_template_set_info>()
                .HasMany(e => e.int_bin_info)
                .WithRequired(e => e.int_template_set_info)
                .HasForeignKey(e => new { e.user_id, e.patient_id, e.template_set_index });

            modelBuilder.Entity<LeadConfiguration>()
                .Property(e => e.MonitorLoaderValue)
                .IsUnicode(false);

            modelBuilder.Entity<LeadConfiguration>()
                .Property(e => e.DataLoaderValue)
                .IsUnicode(false);

            modelBuilder.Entity<LimitAlarmsData>()
                .Property(e => e.SettingViolated)
                .IsUnicode(false);

            modelBuilder.Entity<LimitAlarmsData>()
                .Property(e => e.ViolatingValue)
                .IsUnicode(false);

            modelBuilder.Entity<LimitChangeData>()
                .Property(e => e.High)
                .IsUnicode(false);

            modelBuilder.Entity<LimitChangeData>()
                .Property(e => e.Low)
                .IsUnicode(false);

            modelBuilder.Entity<LimitChangeData>()
                .Property(e => e.ExtremeHigh)
                .IsUnicode(false);

            modelBuilder.Entity<LimitChangeData>()
                .Property(e => e.ExtremeLow)
                .IsUnicode(false);

            modelBuilder.Entity<LimitChangeData>()
                .Property(e => e.Desat)
                .IsUnicode(false);

            modelBuilder.Entity<LiveData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<LiveData>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<LogData>()
                .Property(e => e.PatientID)
                .IsUnicode(false);

            modelBuilder.Entity<MetaData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<MetaData>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<MetaData>()
                .Property(e => e.EntityName)
                .IsUnicode(false);

            modelBuilder.Entity<MetaData>()
                .Property(e => e.EntityMemberName)
                .IsUnicode(false);

            modelBuilder.Entity<ml_duplicate_info>()
                .Property(e => e.Original_ID)
                .IsUnicode(false);

            modelBuilder.Entity<ml_duplicate_info>()
                .Property(e => e.Duplicate_Id)
                .IsUnicode(false);

            modelBuilder.Entity<ml_duplicate_info>()
                .Property(e => e.Original_Monitor)
                .IsUnicode(false);

            modelBuilder.Entity<ml_duplicate_info>()
                .Property(e => e.Duplicate_Monitor)
                .IsUnicode(false);

            modelBuilder.Entity<PrintRequestDescription>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<StatusData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<StatusData>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<TopicType>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<VitalsData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<VitalsData>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<WaveformData>()
                .Property(e => e.TypeName)
                .IsUnicode(false);

            modelBuilder.Entity<WaveformLiveData>()
                .Property(e => e.TypeName)
                .IsUnicode(false);

            modelBuilder.Entity<cdr_navigation_button>()
                .Property(e => e.form_name)
                .IsUnicode(false);

            modelBuilder.Entity<cdr_navigation_button>()
                .Property(e => e.shortcut)
                .IsFixedLength();

            modelBuilder.Entity<Device>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<Device>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<Device>()
                .Property(e => e.Room)
                .IsUnicode(false);

            modelBuilder.Entity<hl7_in_qhist>()
                .Property(e => e.msg_no)
                .HasPrecision(10, 0);

            modelBuilder.Entity<hl7_in_qhist>()
                .Property(e => e.msg_status)
                .IsFixedLength();

            modelBuilder.Entity<hl7_in_queue>()
                .Property(e => e.msg_no)
                .HasPrecision(10, 0);

            modelBuilder.Entity<hl7_in_queue>()
                .Property(e => e.msg_status)
                .IsFixedLength();

            modelBuilder.Entity<hl7_in_queue>()
                .Property(e => e.msh_msg_type)
                .IsFixedLength();

            modelBuilder.Entity<hl7_in_queue>()
                .Property(e => e.msh_event_cd)
                .IsFixedLength();

            modelBuilder.Entity<hl7_in_queue>()
                .Property(e => e.msh_ack_cd)
                .IsFixedLength();

            modelBuilder.Entity<hl7_in_queue>()
                .Property(e => e.patient_id)
                .HasPrecision(10, 0);

            modelBuilder.Entity<hl7_msg_ack>()
                .Property(e => e.msg_control_id)
                .IsFixedLength();

            modelBuilder.Entity<hl7_msg_ack>()
                .Property(e => e.msg_status)
                .IsFixedLength();

            modelBuilder.Entity<hl7_msg_ack>()
                .Property(e => e.clientIP)
                .IsFixedLength();

            modelBuilder.Entity<hl7_msg_ack>()
                .Property(e => e.ack_msg_control_id)
                .IsFixedLength();

            modelBuilder.Entity<hl7_msg_ack>()
                .Property(e => e.ack_system)
                .IsFixedLength();

            modelBuilder.Entity<hl7_msg_ack>()
                .Property(e => e.ack_organization)
                .IsFixedLength();

            modelBuilder.Entity<hl7_out_queue>()
                .Property(e => e.msg_status)
                .IsFixedLength();

            modelBuilder.Entity<hl7_out_queue>()
                .Property(e => e.msg_no)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<hl7_out_queue>()
                .Property(e => e.msh_event_cd)
                .IsFixedLength();

            modelBuilder.Entity<hl7_out_queue>()
                .Property(e => e.msh_msg_type)
                .IsFixedLength();

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.patient_name)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.report_date)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.report_time)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.id_number)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.birthdate)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.age)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.sex)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.height)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.weight)
                .IsUnicode(false);

            modelBuilder.Entity<int_12lead_report_edit>()
                .Property(e => e.interpretation)
                .IsUnicode(false);

            modelBuilder.Entity<int_account>()
                .Property(e => e.tot_payments_amt)
                .HasPrecision(10, 4);

            modelBuilder.Entity<int_account>()
                .Property(e => e.tot_charges_amt)
                .HasPrecision(10, 4);

            modelBuilder.Entity<int_account>()
                .Property(e => e.tot_adjs_amt)
                .HasPrecision(10, 4);

            modelBuilder.Entity<int_account>()
                .Property(e => e.cur_bal_amt)
                .HasPrecision(10, 4);

            modelBuilder.Entity<int_address>()
                .Property(e => e.addr_loc_cd)
                .IsFixedLength();

            modelBuilder.Entity<int_address>()
                .Property(e => e.addr_type_cd)
                .IsFixedLength();

            modelBuilder.Entity<int_alarm_retrieved>()
                .Property(e => e.annotation)
                .IsUnicode(false);

            modelBuilder.Entity<int_alarm_waveform>()
                .Property(e => e.waveform_data)
                .IsUnicode(false);

            modelBuilder.Entity<int_allergy>()
                .Property(e => e.active_sw)
                .IsFixedLength();

            modelBuilder.Entity<int_autoupdate>()
                .Property(e => e.prod)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_autoupdate>()
                .Property(e => e.action)
                .IsUnicode(false);

            modelBuilder.Entity<int_autoupdate_log>()
                .Property(e => e.prod)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_channel_type>()
                .Property(e => e.label)
                .IsUnicode(false);

            modelBuilder.Entity<int_channel_type>()
                .Property(e => e.type_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_channel_type>()
                .Property(e => e.color)
                .IsUnicode(false);

            modelBuilder.Entity<int_channel_type>()
                .Property(e => e.units)
                .IsUnicode(false);

            modelBuilder.Entity<int_channel_vital>()
                .Property(e => e.format_string)
                .IsUnicode(false);

            modelBuilder.Entity<int_code_category>()
                .Property(e => e.cat_code)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_db_ver>()
                .Property(e => e.ver_code)
                .IsUnicode(false);

            modelBuilder.Entity<int_db_ver>()
                .Property(e => e.status_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_db_ver>()
                .Property(e => e.pre_install_pgm)
                .IsUnicode(false);

            modelBuilder.Entity<int_db_ver>()
                .Property(e => e.pre_install_pgm_flags)
                .IsUnicode(false);

            modelBuilder.Entity<int_db_ver>()
                .Property(e => e.install_pgm)
                .IsUnicode(false);

            modelBuilder.Entity<int_db_ver>()
                .Property(e => e.install_pgm_flags)
                .IsUnicode(false);

            modelBuilder.Entity<int_db_ver>()
                .Property(e => e.post_install_pgm)
                .IsUnicode(false);

            modelBuilder.Entity<int_db_ver>()
                .Property(e => e.post_install_pgm_flags)
                .IsUnicode(false);

            modelBuilder.Entity<int_diagnosis_drg>()
                .Property(e => e.drg_approval_ind)
                .IsFixedLength();

            modelBuilder.Entity<int_diagnosis_drg>()
                .Property(e => e.drg_outlier_cost_amt)
                .HasPrecision(10, 4);

            modelBuilder.Entity<int_encounter>()
                .Property(e => e.vip_sw)
                .IsFixedLength();

            modelBuilder.Entity<int_encounter>()
                .Property(e => e.baby_cd)
                .IsFixedLength();

            modelBuilder.Entity<int_encounter>()
                .Property(e => e.recurring_cd)
                .IsFixedLength();

            modelBuilder.Entity<int_encounter>()
                .Property(e => e.bed)
                .IsFixedLength();

            modelBuilder.Entity<int_encounter>()
                .Property(e => e.newborn_sw)
                .IsFixedLength();

            modelBuilder.Entity<int_encounter_map>()
                .Property(e => e.status_cd)
                .IsFixedLength();

            modelBuilder.Entity<int_encounter_tfr_history>()
                .Property(e => e.status_cd)
                .IsFixedLength();

            modelBuilder.Entity<int_encounter_to_hcp_int>()
                .Property(e => e.hcp_role_cd)
                .IsFixedLength();

            modelBuilder.Entity<int_external_organization>()
                .Property(e => e.cat_code)
                .IsFixedLength();

            modelBuilder.Entity<int_feature>()
                .Property(e => e.feature_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_feature>()
                .Property(e => e.descr)
                .IsUnicode(false);

            modelBuilder.Entity<int_gateway>()
                .Property(e => e.gateway_type)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_gateway>()
                .Property(e => e.patient_id_type)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_gateway>()
                .Property(e => e.node_name)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_guarantor>()
                .Property(e => e.type_cd)
                .IsFixedLength();

            modelBuilder.Entity<int_insurance_plan>()
                .Property(e => e.notice_of_admit_sw)
                .IsFixedLength();

            modelBuilder.Entity<int_insurance_policy>()
                .Property(e => e.plcy_deductible_amt)
                .HasPrecision(19, 4);

            modelBuilder.Entity<int_insurance_policy>()
                .Property(e => e.plcy_limit_amt)
                .HasPrecision(19, 4);

            modelBuilder.Entity<int_insurance_policy>()
                .Property(e => e.rm_semi_private_rt)
                .HasPrecision(19, 4);

            modelBuilder.Entity<int_insurance_policy>()
                .Property(e => e.rm_private_rt)
                .HasPrecision(19, 4);

            modelBuilder.Entity<int_insurance_policy>()
                .Property(e => e.cob_code)
                .IsFixedLength();

            modelBuilder.Entity<int_insurance_policy>()
                .Property(e => e.billing_status_code)
                .IsFixedLength();

            modelBuilder.Entity<int_insurance_policy>()
                .Property(e => e.assignment_of_benefits_sw)
                .IsFixedLength();

            modelBuilder.Entity<int_monitor>()
                .Property(e => e.monitor_type_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_mrn_map>()
                .Property(e => e.merge_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_msg_log>()
                .Property(e => e.external_id)
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.tbl_name)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.filler1)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.filler2)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.filler3)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.filler4)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.filler5)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.filler6)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.filler7)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_ascending_key>()
                .Property(e => e.filler8)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.tbl_name)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.filler1)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.filler2)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.filler3)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.filler4)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.filler5)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.filler6)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.filler7)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_nxt_descending_key>()
                .Property(e => e.filler8)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_order_group_detail>()
                .Property(e => e.display_type)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_order_map>()
                .Property(e => e.type_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_organization>()
                .Property(e => e.category_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_organization>()
                .Property(e => e.printer_name)
                .IsUnicode(false);

            modelBuilder.Entity<int_organization>()
                .Property(e => e.alarm_printer_name)
                .IsUnicode(false);

            modelBuilder.Entity<int_outbound_queue>()
                .Property(e => e.msg_status)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_patient>()
                .Property(e => e.organ_donor_sw)
                .IsFixedLength();

            modelBuilder.Entity<int_patient>()
                .Property(e => e.living_will_sw)
                .IsFixedLength();

            modelBuilder.Entity<int_patient_list>()
                .Property(e => e.type_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_patient_list_detail>()
                .Property(e => e.new_results)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_patient_list_link>()
                .Property(e => e.type_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_patient_monitor>()
                .Property(e => e.poll_type)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_patient_monitor>()
                .Property(e => e.monitor_status)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_person_name>()
                .Property(e => e.recognize_nm_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_pref>()
                .Property(e => e.application_id)
                .IsFixedLength();

            modelBuilder.Entity<int_product>()
                .Property(e => e.product_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_product>()
                .Property(e => e.descr)
                .IsUnicode(false);

            modelBuilder.Entity<int_product_access>()
                .Property(e => e.product_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_product_access>()
                .Property(e => e.license_no)
                .IsUnicode(false);

            modelBuilder.Entity<int_product_map>()
                .Property(e => e.product_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_product_map>()
                .Property(e => e.feature_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_result_flag>()
                .Property(e => e.color_foreground)
                .IsUnicode(false);

            modelBuilder.Entity<int_result_flag>()
                .Property(e => e.color_background)
                .IsUnicode(false);

            modelBuilder.Entity<int_security>()
                .Property(e => e.application_id)
                .IsFixedLength();

            modelBuilder.Entity<int_specimen>()
                .Property(e => e.collect_vol_unit_code_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_specimen>()
                .Property(e => e.action_code_id)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_sysgen>()
                .Property(e => e.product_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_sysgen>()
                .Property(e => e.feature_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_sysgen>()
                .Property(e => e.setting)
                .IsUnicode(false);

            modelBuilder.Entity<int_sysgen_audit>()
                .Property(e => e.audit)
                .IsUnicode(false);

            modelBuilder.Entity<int_sysgen_comment>()
                .Property(e => e.comment)
                .IsUnicode(false);

            modelBuilder.Entity<int_telephone>()
                .Property(e => e.phone_loc_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_telephone>()
                .Property(e => e.phone_type_cd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_test_group>()
                .Property(e => e.display_type)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_test_group_detail>()
                .Property(e => e.display_type)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_translate>()
                .Property(e => e.translate_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_translate>()
                .Property(e => e.form_id)
                .IsUnicode(false);

            modelBuilder.Entity<int_translate_list>()
                .Property(e => e.translate_cd)
                .IsUnicode(false);

            modelBuilder.Entity<int_user_settings>()
                .Property(e => e.cfg_name)
                .IsUnicode(false);

            modelBuilder.Entity<int_vital_live>()
                .Property(e => e.vital_value)
                .IsUnicode(false);

            modelBuilder.Entity<int_vital_live>()
                .Property(e => e.vital_time)
                .IsUnicode(false);

            modelBuilder.Entity<int_vital_live_temp>()
                .Property(e => e.vital_value)
                .IsUnicode(false);

            modelBuilder.Entity<int_vital_live_temp>()
                .Property(e => e.vital_time)
                .IsUnicode(false);

            modelBuilder.Entity<int_waveform>()
                .Property(e => e.compress_method)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<int_waveform_live>()
                .Property(e => e.compress_method)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<mpi_decision_log>()
                .Property(e => e.status_code)
                .IsUnicode(false);

            modelBuilder.Entity<mpi_search_field>()
                .Property(e => e.compare_type)
                .IsFixedLength();

            modelBuilder.Entity<PrintRequestData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<PrintRequestData>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<WaveformAnnotationData>()
                .Property(e => e.Annotation)
                .IsUnicode(false);

            modelBuilder.Entity<WaveformPrintData>()
                .Property(e => e.Samples)
                .IsUnicode(false);

            modelBuilder.Entity<v_CombinedEncounters>()
                .Property(e => e.BED)
                .IsFixedLength();

            modelBuilder.Entity<v_CombinedEncounters>()
                .Property(e => e.MERGE_CD)
                .IsUnicode(false);

            modelBuilder.Entity<v_DeviceSessionAssignment>()
                .Property(e => e.BedName)
                .IsFixedLength();

            modelBuilder.Entity<v_DeviceSessionAssignment>()
                .Property(e => e.MonitorName)
                .IsFixedLength();

            modelBuilder.Entity<v_DeviceSessionAssignment>()
                .Property(e => e.Channel)
                .IsFixedLength();

            modelBuilder.Entity<v_DeviceSessionInfo>()
                .Property(e => e.Name)
                .IsFixedLength();

            modelBuilder.Entity<v_DeviceSessionInfo>()
                .Property(e => e.Value)
                .IsFixedLength();

            modelBuilder.Entity<v_FeedGdsCodes>()
                .Property(e => e.GdsCode)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarms>()
                .Property(e => e.AlarmType)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarms>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarms>()
                .Property(e => e.ChannelCode)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarms>()
                .Property(e => e.StrLabel)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarms>()
                .Property(e => e.StrMessage)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarmsLite>()
                .Property(e => e.AlarmType)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarmsLite>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarmsLite>()
                .Property(e => e.ChannelCode)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarmsLite>()
                .Property(e => e.StrLabel)
                .IsUnicode(false);

            modelBuilder.Entity<v_GeneralAlarmsLite>()
                .Property(e => e.StrMessage)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyChannelTypes>()
                .Property(e => e.TopicName)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyChannelTypes>()
                .Property(e => e.CdiLabel)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyChannelTypes>()
                .Property(e => e.TypeName)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyChannelTypes>()
                .Property(e => e.SampleRate)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyChannelTypes>()
                .Property(e => e.ChannelCode)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyChannelTypes>()
                .Property(e => e.label)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyMonitor>()
                .Property(e => e.UnitOrgId)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyMonitor>()
                .Property(e => e.NetworkId)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyMonitor>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyMonitor>()
                .Property(e => e.Type)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyMonitor>()
                .Property(e => e.Subnet)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyMonitorCombined>()
                .Property(e => e.monitor_type_cd)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyPatientMonitorCombined>()
                .Property(e => e.poll_type)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyPatientMonitorCombined>()
                .Property(e => e.monitor_status)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyWaveform>()
                .Property(e => e.TypeName)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyWaveform>()
                .Property(e => e.SampleRate)
                .IsUnicode(false);

            modelBuilder.Entity<v_LegacyWaveform>()
                .Property(e => e.CompressMethod)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarms>()
                .Property(e => e.SettingViolated)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarms>()
                .Property(e => e.ViolatingValue)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarms>()
                .Property(e => e.AlarmType)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarms>()
                .Property(e => e.ChannelCode)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarms>()
                .Property(e => e.StrLabel)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarms>()
                .Property(e => e.StrMessage)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarms>()
                .Property(e => e.StrLimitFormat)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarms>()
                .Property(e => e.StrValueFormat)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarmsLite>()
                .Property(e => e.SettingViolated)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarmsLite>()
                .Property(e => e.ViolatingValue)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarmsLite>()
                .Property(e => e.AlarmType)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarmsLite>()
                .Property(e => e.ChannelCode)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarmsLite>()
                .Property(e => e.StrLabel)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarmsLite>()
                .Property(e => e.StrMessage)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarmsLite>()
                .Property(e => e.StrLimitFormat)
                .IsUnicode(false);

            modelBuilder.Entity<v_LimitAlarmsLite>()
                .Property(e => e.StrValueFormat)
                .IsUnicode(false);

            modelBuilder.Entity<v_LiveVitalsData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<v_LiveVitalsData>()
                .Property(e => e.ResultValue)
                .IsUnicode(false);

            modelBuilder.Entity<v_MetaData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<v_MetaData>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<v_MetaData>()
                .Property(e => e.EntityName)
                .IsUnicode(false);

            modelBuilder.Entity<v_MetaData>()
                .Property(e => e.EntityMemberName)
                .IsUnicode(false);

            modelBuilder.Entity<v_MetaData>()
                .Property(e => e.PairName)
                .IsUnicode(false);

            modelBuilder.Entity<v_MetaData>()
                .Property(e => e.PairValue)
                .IsUnicode(false);

            modelBuilder.Entity<v_MetaData>()
                .Property(e => e.PairEntityName)
                .IsUnicode(false);

            modelBuilder.Entity<v_MetaData>()
                .Property(e => e.PairEntityMember)
                .IsUnicode(false);

            modelBuilder.Entity<v_Monitors>()
                .Property(e => e.channel)
                .IsFixedLength();

            modelBuilder.Entity<v_Monitors>()
                .Property(e => e.monitor_type_cd)
                .IsUnicode(false);

            modelBuilder.Entity<v_Monitors>()
                .Property(e => e.assignment_cd)
                .IsUnicode(false);

            modelBuilder.Entity<v_PatientSessions>()
                .Property(e => e.STATUS)
                .IsUnicode(false);

            modelBuilder.Entity<v_PatientSessions>()
                .Property(e => e.ROOM)
                .IsUnicode(false);

            modelBuilder.Entity<v_PatientSessions>()
                .Property(e => e.BED)
                .IsFixedLength();

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.page_number)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.descr)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.data_node)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.sweep_speed)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.duration)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.num_channels)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.job_type)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.bed)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.recording_time)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.annotation2)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.annotation3)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobs>()
                .Property(e => e.annotation4)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobsWaveform>()
                .Property(e => e.page_number)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobsWaveform>()
                .Property(e => e.waveform_type)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobsWaveform>()
                .Property(e => e.duration)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobsWaveform>()
                .Property(e => e.channel_type)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobsWaveform>()
                .Property(e => e.sweep_speed)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobsWaveform>()
                .Property(e => e.waveform_data)
                .IsUnicode(false);

            modelBuilder.Entity<v_PrintJobsWaveform>()
                .Property(e => e.scale_labels)
                .IsUnicode(false);

            modelBuilder.Entity<v_StatusData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<v_StatusData>()
                .Property(e => e.ResultValue)
                .IsUnicode(false);

            modelBuilder.Entity<v_StatusData>()
                .Property(e => e.GdsCode)
                .IsUnicode(false);

            modelBuilder.Entity<v_StitchedPatients>()
                .Property(e => e.STATUS)
                .IsUnicode(false);

            modelBuilder.Entity<v_TopicTypes>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<v_TopicTypes>()
                .Property(e => e.Label)
                .IsUnicode(false);

            modelBuilder.Entity<v_VitalsData>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<v_VitalsData>()
                .Property(e => e.ResultValue)
                .IsUnicode(false);

            modelBuilder.Entity<v_VitalsData>()
                .Property(e => e.GdsCode)
                .IsUnicode(false);

            modelBuilder.Entity<v_WaveformSampleRate>()
                .Property(e => e.SampleRate)
                .IsUnicode(false);

            modelBuilder.Entity<v_WaveformSampleRate>()
                .Property(e => e.TypeName)
                .IsUnicode(false);

            modelBuilder.Entity<vwMetaDataValueNum>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<vwMetaDataValueNum>()
                .Property(e => e.Value)
                .IsUnicode(false);

            modelBuilder.Entity<vwMetaDataValueNum>()
                .Property(e => e.EntityName)
                .IsUnicode(false);

            modelBuilder.Entity<vwMetaDataValueNum>()
                .Property(e => e.EntityMemberName)
                .IsUnicode(false);

            modelBuilder.Entity<vwMetaDataValueNum>()
                .Property(e => e.ValueNum)
                .HasPrecision(18, 6);
        }
    }
}
