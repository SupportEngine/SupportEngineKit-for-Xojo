#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Method, Flags = &h0
		Function SupportEngineKitCreate(Company As String, Name As String, Email As String, Priority As String, Subject As String, Message As String, Category As String) As Boolean
		  // Init
		  SupportEngineKitError = ""
		  
		  Try
		    // Validate required inputs
		    If SupportEngineKitToken = "YOUR_API_TOKEN" Or SupportEngineKitToken.Trim = "" Then
		      SupportEngineKitError = "API token is required"
		      Return False
		    End If
		    
		    If SupportEngineKitURL = "https://yourdomain.com/api/" Or SupportEngineKitURL.Trim = "" Then
		      SupportEngineKitError = "API URL is required"
		      Return False
		    End If
		    
		    If Name = "" Or Name.Trim = "" Then
		      SupportEngineKitError = "Name is required"
		      Return False
		    End If
		    
		    If Email = "" Or Email.Trim = "" Then
		      SupportEngineKitError = "Email is required"
		      Return False
		    End If
		    
		    If Email.Contains("@") Then
		    else
		      SupportEngineKitError = "Email address is not valid"
		      Return False
		    End If
		    
		    If Subject = "" Or Subject.Trim = "" Then
		      SupportEngineKitError = "Subject is required"
		      Return False
		    End If
		    
		    If Message = "" Or Message.Trim = "" Then
		      SupportEngineKitError = "Message is required"
		      Return False
		    End If
		    
		    // Prepare the JSON payload with safe value assignment
		    Var payload As New Dictionary
		    
		    payload.Value("company") = Company.Trim
		    payload.Value("name") = Name.Trim
		    payload.Value("user_email") = Email.Trim
		    payload.Value("subject") = Subject.Trim
		    payload.Value("message") = Message.Trim
		    
		    // Safe category conversion
		    If Category <> "" And Category.Trim <> "" Then
		      Try
		        payload.Value("category_id") = Category.ToInteger
		      Catch
		        // If category conversion fails, omit it or use default
		        payload.Value("category_id") = 0
		      End Try
		    Else
		      payload.Value("category_id") = 0
		    End If
		    
		    
		    // Convert the payload to JSON with error handling
		    Var jsonGenerator As JSONItem
		    Var jsonPayload As String
		    
		    Try
		      jsonGenerator = New JSONItem(payload)
		      jsonPayload = jsonGenerator.ToString
		    Catch e As RuntimeException
		      SupportEngineKitError = "Failed to create JSON payload: " + e.Message
		      Return False
		    End Try
		    
		    If jsonPayload = "" Or jsonPayload.Trim = "" Then
		      SupportEngineKitError = "Generated JSON payload is empty"
		      Return False
		    End If
		    
		    // Create the connection with safe URL construction
		    Var conn As URLConnection
		    Var urlAPI As String
		    
		    Try
		      conn = New URLConnection
		      If conn = Nil Then
		        SupportEngineKitError = "Failed to create URL connection"
		        Return False
		      End If
		      
		      // Safe URL construction
		      urlAPI = SupportEngineKitURL.Trim
		      If Not urlAPI.EndsWith("/") Then
		        urlAPI = urlAPI + "/"
		      End If
		      urlAPI = urlAPI + "tickets_create.php"
		      
		      // Set headers safely
		      conn.RequestHeader("Content-Type") = "application/json"
		      conn.RequestHeader("Authorization") = "Bearer " + SupportEngineKitToken.Trim
		      conn.RequestHeader("Accept") = "application/json"
		      
		      
		    Catch e As RuntimeException
		      SupportEngineKitError = "Failed to configure connection: " + e.Message
		      Return False
		    End Try
		    
		    // Send request with comprehensive error handling
		    Try
		      conn.SetRequestContent(jsonPayload, "application/json")
		      Var response As String = conn.SendSync("POST", urlAPI)
		      
		      // Validate response
		      If response = "" Or response.Trim = "" Then
		        SupportEngineKitError = "Received empty response from server"
		        Return False
		      End If
		      
		      // Parse the response safely
		      Var jsonResponse As JSONItem
		      Try
		        jsonResponse = New JSONItem(response)
		      Catch e As RuntimeException
		        SupportEngineKitError = "Invalid JSON response: " + e.Message
		        Return False
		      End Try
		      
		      If jsonResponse = Nil Then
		        SupportEngineKitError = "Failed to parse JSON response"
		        Return False
		      End If
		      
		      // Check for success
		      If jsonResponse.HasKey("success") Then
		        Var successValue As Variant = jsonResponse.Value("success")
		        If successValue <> Nil And successValue = True Then
		          Return True
		        End If
		      End If
		      
		      // Handle error response
		      If jsonResponse.HasKey("error") Then
		        Var errorValue As Variant = jsonResponse.Value("error")
		        If errorValue <> Nil Then
		          SupportEngineKitError = errorValue.StringValue
		        Else
		          SupportEngineKitError = "Unknown error occurred"
		        End If
		      Else
		        SupportEngineKitError = "Request failed without specific error message"
		      End If
		      
		      Return False
		      
		    Catch e As RuntimeException
		      SupportEngineKitError = "Network error: " + e.Message
		      Return False
		    End Try
		    
		  Catch e As RuntimeException
		    SupportEngineKitError = "Unexpected error: " + e.Message
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		SupportEngineKitError As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SupportEngineKitToken As String = "YOUR_API_TOKEN"
	#tag EndProperty

	#tag Property, Flags = &h0
		SupportEngineKitURL As String = "https://yourdomain.com/api/"
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SupportEngineKitToken"
			Visible=false
			Group="Behavior"
			InitialValue="YOUR_API_TOKEN"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SupportEngineKitURL"
			Visible=false
			Group="Behavior"
			InitialValue="https://yourdomain.com/api/"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SupportEngineKitError"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
