package com.datatactics.l3.fcc.atlas.ecfs;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.solr.common.SolrInputDocument;

public class DocumentFactory {
    
    private static long idCounter = 0;

    private String id;
    private String applicant;
    private String applicant_sort;
    private String brief;
    private String city;
    private String dateRcpt;
    private String disseminated;
    private String exParte;
    private String modified;
    private String pages;
    private String proceeding;
    private String regFlexAnalysis;
    private String smallBusinessImpact;
    private String stateCd;
    private String submissionType;
    private String text;
    private String viewingStatus;
    private String zip;
    private float  score;
    
    public DocumentFactory() {
        String now = formatNow();
        
        id = Long.toString(++idCounter);
        
        applicant           = "_";
        applicant_sort      = "_";
        brief               = "_";
        city                = "_";
        dateRcpt            = now;
        disseminated        = now;
        exParte             = "_";
        modified            = now;
        pages               = "0";
        proceeding          = "_";
        regFlexAnalysis     = "_";
        smallBusinessImpact = "_";
        stateCd             = "_";
        submissionType      = "_";
        text                = "_";
        viewingStatus       = "_";
        zip                 = "_";
        score               = 0.0f;
    }
    
    private String formatNow() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'"); 
        return dateFormat.format(Calendar.getInstance().getTime());
    }
    
    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public void setApplicant(String applicant) {
        this.applicant = applicant;
    }
    
    public void setApplicant_Sort(String applicant_sort) {
        this.applicant_sort = applicant_sort;
    }
    
    public void setBrief(String brief) {
        this.brief = brief;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public void setDateRcpt(String dateRcpt) {
        this.dateRcpt = dateRcpt;
    }
    
    public void setDisseminated(String disseminated) {
        this.disseminated = disseminated;
    }
    
    public void setExParte(String exParte) {
        this.exParte = exParte;
    }
    
    public void setModified(String modified) {
        this.modified = modified;
    }
    
    public void setPages(String pages) {
        this.pages = pages;
    }
    
    public void setProceeding(String proceeding) {
        this.proceeding = proceeding;
    }
    
    public void setRegFlexAnalysis(String regFlexAnalysis) {
        this.regFlexAnalysis = regFlexAnalysis;
    }
    
    public void setSmallBusinessImpact(String smallBusinessImpact) {
        this.smallBusinessImpact = smallBusinessImpact;
    }
    
    public void setStateCd(String stateCd) {
        this.stateCd = stateCd;
    }
    
    public void setSubmissionType(String submissionType) {
        this.submissionType = submissionType;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    
    public void setViewingStatus(String viewingStatus) {
        this.viewingStatus = viewingStatus;
    }
    
    public void setZip(String zip) {
        this.zip = zip;
    }
    
    public SolrInputDocument createSolrInputDocument() {

        SolrInputDocument document = new SolrInputDocument();
        
        document.addField("id", id);
        document.addField("applicant", applicant);
        document.addField("applicant_sort", applicant_sort);
        document.addField("brief", brief);
        document.addField("city", city);
        document.addField("dateRcpt", dateRcpt);
        document.addField("disseminated", disseminated);
        document.addField("exParte", exParte);
        document.addField("modified", modified);
        document.addField("pages", pages);
        document.addField("proceeding", proceeding);
        document.addField("regFlexAnalysis", regFlexAnalysis);
        document.addField("scorex", score);
        document.addField("smallBusinessImpact", smallBusinessImpact);
        document.addField("stateCd", stateCd);
        document.addField("submissionType", submissionType);
        document.addField("text", text);
        document.addField("viewingStatus", viewingStatus);
        document.addField("zip", zip);
        document.addField("deleted", false);
        
        return document;
    }
    
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append("@");
        builder.append(hashCode());
        builder.append(":");
        builder.append(String.format("\n\t%1$40s %2$s", "id", id));
        builder.append(String.format("\n\t%1$40s %2$s", "applicant", applicant));
        builder.append(String.format("\n\t%1$40s %2$s", "applicant_sort", applicant_sort));
        builder.append(String.format("\n\t%1$40s %2$s", "brief", brief));
        builder.append(String.format("\n\t%1$40s %2$s", "city", city));
        builder.append(String.format("\n\t%1$40s %2$s", "dateRcpt", dateRcpt));
        builder.append(String.format("\n\t%1$40s %2$s", "disseminated", disseminated));
        builder.append(String.format("\n\t%1$40s %2$s", "exParte", exParte));
        builder.append(String.format("\n\t%1$40s %2$s", "modified", modified));
        builder.append(String.format("\n\t%1$40s %2$s", "pages", pages));
        builder.append(String.format("\n\t%1$40s %2$s", "proceeding", proceeding));
        builder.append(String.format("\n\t%1$40s %2$s", "regFlexAnalysis", regFlexAnalysis));
        builder.append(String.format("\n\t%1$40s %2$s", "smallBusinessImpact", smallBusinessImpact));
        builder.append(String.format("\n\t%1$40s %2$s", "stateCd", stateCd));
        builder.append(String.format("\n\t%1$40s %2$s", "submissionType", submissionType));
        builder.append(String.format("\n\t%1$40s %2$s", "viewingStatus", viewingStatus));
        builder.append(String.format("\n\t%1$40s %2$s", "zip", zip));
        builder.append(String.format("\n\t%1$40s %2$s", "deleted", false));
        builder.append(String.format("\n\t%1$40s %2$s", "text", text));
        
        return builder.toString();
    }
}
