package preventative_care

type RecommendedPreventativeCareItem struct {
	Id             int    `json:"id,omitempty"`
	SearchTerm     string `json:"searchTerm,omitempty"`
	Title          string `json:"title,omitempty"`
	Description    string `json:"description,omitempty"`
	Gender         string `json:"gender,omitempty"`
	AgeRangeMin    int    `json:"ageRangeMin,omitempty"`
	AgeRangeMax    int    `json:"ageRangeMax,omitempty"`
	SmokingHistory bool   `json:"smokingHistory,omitempty"`
	Recurring      bool   `json:"isRecurring,omitempty"`
	AnnualInterval int    `json:"annualInterval,omitempty"`
}

type RecommendedPreventativeCareItemRequest struct {
	Age    int
	Gender string
}

type RecommendedPreventativeCareItemResponse struct {
	RecommendedPreventativeCareItems []RecommendedPreventativeCareItem `json:"items,omitempty"`
}
