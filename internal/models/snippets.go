package models

import (
	"database/sql"
	"errors"
	"time"
)

type Snippet struct {
	ID      int       `json:"id"`
	Title   string    `json:"title"`
	Content string    `json:"content"`
	Created time.Time `json:"created"`
	Expires time.Time `json:"expires"`
}

type SnippetModel struct {
	DB *sql.DB
}

func (m *SnippetModel) Insert(title string, content string, expires int) (int, error) {
	query := `INSERT INTO snippets (title, content, created, expires)
            VALUES($1, $2, NOW(), NOW() + $3 * INTERVAL '1 day')
            RETURNING id`

	stmt, err := m.DB.Prepare(query)
	if err != nil {
		return 0, err
	}

	var id int
	err = stmt.QueryRow(title, content, expires).Scan(&id)
	if err != nil {
		return 0, err
	}
	return id, nil
}

func (m *SnippetModel) Latest() ([]*Snippet, error) {
	return nil, nil
}

func (m *SnippetModel) Get(id int) (*Snippet, error) {
	query := `SELECT id, title, content, created, expires FROM snippets
            WHERE expires > NOW() AND id = $1`

	stmt, err := m.DB.Prepare(query)
	if err != nil {
		return nil, err
	}

	s := &Snippet{}
	err = stmt.QueryRow(id).Scan(&s.ID, &s.Title, &s.Content, &s.Created, &s.Expires)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, ErrNoRecord
		} else {
			return nil, err
		}
	}
	return s, nil
}
