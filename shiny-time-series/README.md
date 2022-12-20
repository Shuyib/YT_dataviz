# build the image  
```bash
docker build -t shiny-time-series .
```

# run the image   
```bash
docker run -p 3838:3838 shiny-time-series
```

# open the app in the browser   
http://localhost:3838