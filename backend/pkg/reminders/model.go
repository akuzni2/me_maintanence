package reminders

type Reminder struct {
	Id                 int    `json:"id"`
	PreventativeCareId int    `json:"preventativeCareId"`
	Username           string `json:"username"`
	ReminderDateEpoch  int    `json:"reminderDateEpoch"`
}

type ReminderInformation struct {
	Id                    int
	Username              string
	NextReminderDateEpoch int
	PreventativeCareTitle string
	Recurring             bool
	AnnualInterval        float32
	PhoneNumber           string
}

type GetRemindersResponse struct {
	Reminders []Reminder `json:"reminders,omitempty"`
}
