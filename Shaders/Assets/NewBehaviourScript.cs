using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Net;
using System;
using System.IO;

public class NewBehaviourScript : MonoBehaviour {
    private void Start()
    {
        Debug.Log("hey");
        WeatherInfo x = GetWeather();
        Debug.Log(x.name);
    }
    private const string API_KEY = "0f654b3fa45c9551e98259d5666316f9";
    public string CityId;
    [Serializable]
    public class Weather
    {
        public int id;
        public string main;
    }
    [Serializable]
    public class WeatherInfo
    {
        public int id;
        public string name;
        public List<Weather> weather;
    }
    private WeatherInfo GetWeather()
    {
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(String.Format("http://api.openweathermap.org/data/2.5/weather?id={0}&APPID={1}", CityId, API_KEY));
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        StreamReader reader = new StreamReader(response.GetResponseStream());
        string jsonResponse = reader.ReadToEnd();
        WeatherInfo info = JsonUtility.FromJson<WeatherInfo>(jsonResponse);
        return info;
    }
}
