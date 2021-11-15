package user

type User struct {
	Username          string `json:"username,omitempty"`
	Password          string `json:"password,omitempty"`
	PhoneNumer        string `json:"phone_number,omitempty"`
	FhirServerAddress string `json:"fhir_server_address,omitempty"`
	PatientId         string `json:"patient_id,omitempty"`
}