package neu.cs5200.otr.entity;


import java.sql.Date;
/**
 * Created by shunlin on 3/21/15.
 */
public class Location {
	private int locationId;
	private String name;
	private String state;
	private String country;
	private String placeIntro;
	private Date addTime;
	
	public Location(int locationId, String name, String state, String country, String placeIntro, Date addTime){
		this.locationId = locationId;
		this.name = name;
		this.state = state;
		this.country = country;
		this.placeIntro = placeIntro;
		this.addTime = addTime;
	}
	
	public Location(String name, String state, String country, String placeIntro){
		this.locationId = -1;
		this.name = name;
		this.state = state;
		this.country = country;
		this.placeIntro = placeIntro;
	}
	
	public void setLocationId(int locationId){
		this.locationId = locationId;
	}
	
	public void setName(String name){
		this.name = name;
	}
	
	public void setCountry(String country){
		this.country = country;
	}
	
	public void setState(String state){
		this.state = state;
	}
	
	public void setPlaceIntro(String placeIntro){
		this.placeIntro = placeIntro;
	}
	
	public void setAddTime(Date addTime){
		this.addTime = addTime;
	}
	
	public int getLocationId(){
		return this.locationId;
	}
	
	public String getName(){
		return this.name;
	}
	
	public String getCountry(){
		return this.country;
	}
	
	public String getState(){
		return this.state;
	}
	
	public String getPlaceIntro(){
		return this.placeIntro;
	}
	
	public Date getAddTime() {
		return this.addTime;
	}
}