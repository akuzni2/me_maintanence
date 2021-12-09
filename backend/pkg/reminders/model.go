package reminders

type Reminder struct {
	Id                 int    `json:"id"`
	PreventativeCareId int    `json:"preventativeCareId"`
	Username           string `json:"username"`
	ReminderDateEpoch  int    `json:"reminderDateEpoch"`
	Completed          bool   `json:"completed"`
}

type ReminderInformation struct {
	Id                    int
	Username              string
	NextReminderDateEpoch int64
	PreventativeCareTitle string
	Recurring             bool
	AnnualInterval        float64
	PhoneNumber           string
	PreventativeCareId    int
}

type GetRemindersResponse struct {
	Reminders []Reminder `json:"reminders,omitempty"`
}
