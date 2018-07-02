package main

import (
	"bytes"
	"io/ioutil"
	"log"
	"regexp"

	"github.com/fatih/color"
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.Use(reqLogger())
	router.GET("/", func(context *gin.Context) {
		context.JSON(200, gin.H{"app": "budgetbro API"})
	})
	router.POST("/fulfillment")
	router.Run()
}

func reqLogger() gin.HandlerFunc {
	return func(context *gin.Context) {
		// skip log if req is a file upload
		header := context.GetHeader("Content-Type")
		// check if incoming header is multipart form
		upload, _ := regexp.MatchString("multipart/form-data", header)
		if upload {
			log.Printf("File upload recognized. Header: %s\n", header)
			context.Next()
			return
		}

		bodyBytes, err := ioutil.ReadAll(context.Request.Body)
		if err != nil {
			log.Println("Unable to read request body: ", err.Error())
			context.Next()
			return
		}

		// restore the io.ReadCloser to its original state
		context.Request.Body = ioutil.NopCloser(bytes.NewBuffer(bodyBytes))
		// set bytes into readable string
		bodyString := string(bodyBytes)
		// log request body
		color.Cyan("Request header: %s \n", header)
		color.Cyan("Request body: ")
		color.Cyan(bodyString)

		context.Next()
	}
}
