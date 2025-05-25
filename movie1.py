import dash
from dash import Dash, html, dcc, callback, Output, Input, clientside_callback, State
import dash_bootstrap_components as dbc
import pandas as pd
import requests
import json
import os

OMDB_API_KEY = 'd3e2b7b7'

def get_token(username="admin@example.com", password="changethis"):
	url = "http://localhost:8000/api/v1/login/access-token"
	payload = {
		'username': username,
		'password': password
	}
	headers = {
		'Accept': 'application/json',
		'Origin': 'http://localhost:5173',
		'Referer': 'http://localhost:5173/'
	}
	response = requests.post(url, headers=headers, data=payload)
	if response.status_code == 200:
		try:
			return response.json().get("access_token", "")
		except Exception:
			return ""
	return ""


# df = pd.read_csv("./movies_metadata.csv", low_memory=False)
df = pd.read_pickle("for_frontend.pkl")
# df.release_date = pd.to_datetime(df.release_date, errors='coerce')
# df['release_year'] = df.release_date.dt.year.astype('Int64')

movie_df = pd.read_pickle("./stg_movie_metadata.pkl")
all_movies = movie_df['title'].dropna().unique().tolist()

def fetch_all_api_genres():
	url = "http://localhost:8000/api/v1/genres"
	payload = {}
	headers = {
		'accept': 'application/json'
	}
	try:
		response = requests.get(url, headers=headers, data=payload)
		if response.status_code == 200:
			return response.json()
		else:
			return []
	except Exception:
		return []

all_genres = fetch_all_api_genres()

num_suggestions = 20

def get_movie_poster(imdb_id: str) -> str:

	url = f"http://www.omdbapi.com/?i={imdb_id}&apikey={OMDB_API_KEY}"
	response = requests.get(url)
	data = response.json()
	return data.get('Poster', '')

def get_movies_by_movie_id(movie_id, limit=20):
	"""
	Lấy danh sách phim tương tự dựa trên movieId
	"""
	url = "http://localhost:8000/api/v1/recommender/content-base"
	
	payload = json.dumps({
		"movieId": movie_id,
		"limit": limit
	})
	headers = {
		'Accept': 'application/json',
		'Content-Type': 'application/json'
	}
	
	response = requests.request("POST", url, headers=headers, data=payload)
	
	if response.status_code == 200:
		# print(response.json())
		return response.json()['recommendations']
	else:
		raise Exception(f"Error fetching movies: {response.status_code} - {response.text}")

def get_movies_by_genres(genres, limit=20):
	url = "http://localhost:8000/api/v1/recommender/by-genres"
	
	payload = json.dumps({
		"genres": genres,
		"limit": limit
	})
	headers = {
		'Accept': 'application/json',
		'Content-Type': 'application/json'
	}
	
	response = requests.request("POST", url, headers=headers, data=payload)
	
	if response.status_code == 200:
		# print(response.json())
		return response.json()['recommendations']
	else:
		raise Exception(f"Error fetching movies: {response.status_code} - {response.text}")


def create_card(card_id: int) -> dbc.Card:

	return dbc.Card(
		dbc.CardBody(
			[
				html.Img(src="", id=f"card-img-{card_id}", style={"width": "100%", "height": "300px", "object-fit": "cover", "margin-bottom": "10px"}),
				html.H4("Title", id=f"card-title-{card_id}", style={"text-align": "center", "white-space": "nowrap", "overflow": "hidden", "text-overflow": "ellipsis"}, title="Title"),
				html.H6("Card subtitle", id=f"card-subtitle-{card_id}", style={"text-align": "center", "color": "#6c757d"}),
				html.Div(
					[
						dbc.CardLink("Trailer", id=f"card-trailer-{card_id}", href="https://www.youtube.com/results?search_query=up+trailer", target="_blank", style={"text-align": "center", "margin": "0 5px"}),
						dbc.CardLink("Info", id=f"card-info-{card_id}", href=f"https://www.imdb.com/title/tt1049413/", target="_blank", style={"text-align": "center", "margin": "0 5px"}),
					],
					style={"text-align": "center"}
				),
			]
		),
		style={"width": "18rem", "margin": "10px"}
	)

def create_buttons() -> list:

	return [
		dbc.Col(
			dbc.Button(
				[
					html.Img(src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png", style={"width": "20px", 'margin': '0px 10px 5px 0px'}),
					"Phim đã xem"
				],
				id="button-model-1",
				color="light",
				outline=True,
				style={"width": "18rem", "border": "2px solid #6c757d", "color": "#6c757d", "transition": "all 0.3s", "textAlign": "left"},
				className="hover-button"
			),
			width='auto',
			style={"margin": "10px"}
		),
		dbc.Col(
			dbc.Button(
				[
					html.Img(src="https://cdn-icons-png.flaticon.com/512/833/833472.png", style={"width": "20px", 'margin': '0px 10px 5px 0px'}),
					"Thể loại phim yêu thích"
				],
				id="button-model-2",
				color="light",
				outline=True,
				style={"width": "18rem", "border": "2px solid #6c757d", "color": "#6c757d", "transition": "all 0.3s", "textAlign": "left"},
				className="hover-button"
			),
			width='auto',
			style={"margin": "10px"}
		),
	]


cards = [dbc.Col(create_card(i), className='d-flex justify-content-center', width=3) for i in range(0, num_suggestions)]


buttons = create_buttons()

color_mode_switch =  html.Span(
	[
		dbc.Label(className="fa fa-moon", html_for="switch"),
		dbc.Switch( id="switch", value=True, className="d-inline-block ms-1", persistence=True),
		dbc.Label(className="fa fa-sun", html_for="switch"),
	]
)

dbc_css = "https://cdn.jsdelivr.net/gh/AnnMarieW/dash-bootstrap-templates/dbc.min.css"


app = Dash(__name__, external_stylesheets=[dbc.themes.FLATLY, dbc.icons.FONT_AWESOME, dbc_css])
server = app.server

navbar = dbc.NavbarSimple(
	id='navbar',
	brand=html.Div(
		[
			html.Img(src="/assets/owl-logo.png", height="30px", style={"margin-right": "10px"}),  
			"Cú Cine"
		],
		style={"display": "flex", "align-items": "center"}
	),
	brand_href="#",
	children=[
		dbc.Nav(
			[
				dbc.NavItem(dbc.NavLink("Home", href="#")),
				dbc.NavItem(dbc.NavLink("About", href="#")),
				dbc.NavItem(dbc.NavLink("Contact", href="#")),
				dbc.NavItem(color_mode_switch, style={'padding':'8px 8px 8px 8px'}),
			],
		),
	],
	fixed="top",
	className="dbc",
)

app.layout = dbc.Container([
	navbar,
	html.Div(
		className="scroll-container",
		style={'padding-top': '70px', 'padding-bottom': '0px'},  
		children=[
			html.Div(
				className="scroll-content",
				children=[
					html.Img(
						src=get_movie_poster(imdb_id),
						style={'height': '100px', 'margin-right': '10px'}
					) for imdb_id in df.sort_values(by='popularity', ascending=False).head(20)['imdb_id'].dropna().tolist()
				] * 3
			)
		]
	),
	html.Hr(),
	dbc.Row(
		html.Div(
			html.Img(src="/assets/owl-logo.png", height='260px', style={"margin-top": "10px"}),
			style={"textAlign": "center"} 
		)
	),
	html.H1('Cú Cine', style={'textAlign': 'center', 'margin-top': '10px'}), 
	html.P("Xin chào chủ nhân", style={'textAlign': 'center'}),
	html.P("Cú Cine là ứng dụng gợi ý phim dựa trên sở thích của chủ nhân!", style={'textAlign': 'center'}),
	html.P("Bước 1: Chủ nhân có muốn tôi gợi ý phim không?", style={'textAlign': 'center'}),
	dbc.Row(
		[
			dbc.Col(
				dbc.Button("Có", id="button-yes", color="success", style={"margin": "10px"}),
				width='auto',
				style={'margin':'10px'}
			),dbc.Col(
				dbc.Button("Không", id="button-no", color="danger", style={"margin": "10px"}),
				width='auto',
				style={'margin':'10px'}
			),
		],
		justify='center'
	),
	html.P("Bước 2: Chủ nhân muốn tìm phim dựa theo...", style={'textAlign': 'center'}),
	dbc.Row(buttons, justify='center'),
	html.P("Bước 3: Chủ nhân hãy lựa chọn...", style={'textAlign': 'center'}),
	dcc.Dropdown(
		options=[],
		value=[],
		id='dropdown-selection',
		placeholder='Phim hay Thể loại?',
		multi=True,
		style={'margin': '0 auto', 'width': '100%', 'maxWidth': '500px'}
	),
	dbc.Row(
		dbc.Col(
			dbc.Button("Gợi ý phim", id="dropdown-submit", color="primary", style={"margin-top": "10px"}),
			width='auto',
			style={'textAlign': 'center'}
		),
		justify='center'
	),
	html.Br(),
	html.H5("Cú Cine chúc chủ nhân có những giây giúp xem phim vui vẻ!", style={'textAlign': 'center'}),
	dbc.Row(cards, style={'margin-top': '10px'}),
], style={'padding': '10px'}, className="dbc")

@callback(
	[Output("button-model-1", "style"), Output("button-model-2", "style"), Output("dropdown-selection", "options"), Output("dropdown-selection", "value"), Output("dropdown-selection","placeholder")],
	[Input("button-model-1", "n_clicks"), Input("button-model-2", "n_clicks")],
	prevent_initial_call=True
)
def update_button_styles_and_dropdown(btn1_clicks, btn2_clicks):
	default_style = {"width": "18rem", "border": "2px solid #6c757d", "color": "#6c757d", "transition": "all 0.3s", "textAlign": "left"}
	active_style = {"width": "18rem", "border": "2px solid #6c757d", "color": "#ffffff", "background-color": "#6c757d", "transition": "all 0.3s", "textAlign": "left"}
	
	ctx = dash.callback_context
	if not ctx.triggered:
		return [default_style, default_style, [], [], "Phim hay Thể loại?"]
	
	triggered_id = ctx.triggered[0]["prop_id"].split(".")[0]
	if triggered_id == "button-model-1":
		options = all_movies
		return [active_style, default_style, options, [], "Phim yêu thích..."]
	elif triggered_id == "button-model-2":
		options = all_genres
		return [default_style, active_style, options, [], "Thể loại yêu thích..."]
	return [default_style, default_style, [], []]

@callback(
	[Output(f'card-title-{i}', 'children') for i in range(0, num_suggestions)] +
	[Output(f'card-title-{i}', 'title') for i in range(0, num_suggestions)] +
	[Output(f'card-subtitle-{i}', 'children') for i in range(0, num_suggestions)] +
	[Output(f'card-img-{i}', 'src') for i in range(0, num_suggestions)] + 
	[Output(f'card-info-{i}', 'href') for i in range(0, num_suggestions)] +
	[Output(f'card-trailer-{i}', 'href') for i in range(0, num_suggestions)],
	Input('dropdown-submit', 'n_clicks'),
	State('dropdown-selection', 'value'),
	State('button-model-1', 'n_clicks'),
	State('button-model-2', 'n_clicks'),
)
def update_cards(_, selected_value, btn1_clicks, btn2_clicks):
	default_titles = ["N/A"] * num_suggestions
	default_subtitles = ["N/A"] * num_suggestions
	default_posters = ["/assets/owl.png"] * num_suggestions
	default_infos = ["N/A"] * num_suggestions
	default_trailers = ["N/A"] * num_suggestions

	ctx = dash.callback_context
	if not ctx.triggered or not selected_value:
		return default_titles + default_titles + default_subtitles + default_posters + default_infos + default_trailers

	# Determine which button was last clicked
	triggered_id = None
	if ctx.triggered:
		prop_id = ctx.triggered[0]['prop_id']
		if prop_id.startswith('button-model-1'):
			triggered_id = 'button-model-1'
		elif prop_id.startswith('button-model-2'):
			triggered_id = 'button-model-2'
		elif prop_id.startswith('dropdown-submit'):
			if (btn1_clicks or 0) > (btn2_clicks or 0):
				triggered_id = 'button-model-1'
			elif (btn2_clicks or 0) > (btn1_clicks or 0):
				triggered_id = 'button-model-2'
			else:
				triggered_id = None

	# Always use df from for_frontend.pkl for output info
	output_df = pd.read_pickle("for_frontend.pkl")

	if triggered_id == 'button-model-1':
		# By movie - use get_movies_by_movie_id
		movie_title = selected_value[0] if selected_value else None
		if not movie_title or movie_title not in movie_df['title'].values:
			return default_titles + default_titles + default_subtitles + default_posters + default_infos + default_trailers
		movie_row = movie_df[movie_df['title'] == movie_title].iloc[0]
		movie_id = movie_row.get('id')
		if pd.isna(movie_id):
			return default_titles + default_titles + default_subtitles + default_posters + default_infos + default_trailers
		try:
			api_results = get_movies_by_movie_id(int(movie_id), num_suggestions)
		except Exception:
			api_results = []
		if not api_results:
			return default_titles + default_titles + default_subtitles + default_posters + default_infos + default_trailers

		titles, subtitles, posters, infos, trailers = [], [], [], [], []
		for m in api_results:
			# Try to find movie in output_df by imdb_id or title
			imdb_id = m.get('imdb_id')
			title = m.get('original_title') or m.get('title') or "N/A"
			row = None
			if imdb_id and imdb_id in output_df['imdb_id'].values:
				row = output_df[output_df['imdb_id'] == imdb_id].iloc[0]
			elif title and title in output_df['title'].values:
				row = output_df[output_df['title'] == title].iloc[0]
			# Title
			titles.append(row['title'] if row is not None and 'title' in row else title)
			# Subtitle (year)
			if row is not None and 'release_year' in row and not pd.isna(row['release_year']):
				subtitles.append(str(int(row['release_year'])))
			elif 'release_year' in m and m['release_year']:
				subtitles.append(str(m['release_year']))
			elif 'release_date' in m and m['release_date']:
				try:
					subtitles.append(str(pd.to_datetime(m['release_date']).year))
				except Exception:
					subtitles.append("N/A")
			elif 'year' in m and m['year']:
				subtitles.append(str(m['year']))
			else:
				subtitles.append("N/A")
			# Poster
			poster_url = ""
			if row is not None and 'imdb_id' in row and pd.notna(row['imdb_id']):
				poster_url = get_movie_poster(row['imdb_id'])
			elif imdb_id:
				poster_url = get_movie_poster(imdb_id)
			if poster_url and poster_url != "N/A":
				posters.append(poster_url)
			else:
				posters.append("/assets/owl.png")
			# Info
			if row is not None and 'imdb_id' in row and pd.notna(row['imdb_id']):
				infos.append(f"https://www.imdb.com/title/{row['imdb_id']}/")
			elif imdb_id:
				infos.append(f"https://www.imdb.com/title/{imdb_id}/")
			else:
				infos.append("N/A")
			# Trailer
			trailers.append(f"https://www.youtube.com/results?search_query={title.replace(' ', '+')}+trailer" if title != "N/A" else "N/A")

	elif triggered_id == 'button-model-2':
		# By genres - use get_movies_by_genres
		try:
			api_results = get_movies_by_genres(selected_value, num_suggestions)
		except Exception:
			api_results = []

		if not api_results:
			return default_titles + default_titles + default_subtitles + default_posters + default_infos + default_trailers

		titles, subtitles, posters, infos, trailers = [], [], [], [], []
		for m in api_results:
			imdb_id = m.get('imdb_id')
			title = m.get('original_title') or m.get('title') or "N/A"
			row = None
			if imdb_id and imdb_id in output_df['imdb_id'].values:
				row = output_df[output_df['imdb_id'] == imdb_id].iloc[0]
			elif title and title in output_df['title'].values:
				row = output_df[output_df['title'] == title].iloc[0]
			# Title
			titles.append(row['title'] if row is not None and 'title' in row else title)
			# Subtitle (year)
			if row is not None and 'release_year' in row and not pd.isna(row['release_year']):
				subtitles.append(str(int(row['release_year'])))
			elif 'release_year' in m and m['release_year']:
				subtitles.append(str(m['release_year']))
			elif 'release_date' in m and m['release_date']:
				try:
					subtitles.append(str(pd.to_datetime(m['release_date']).year))
				except Exception:
					subtitles.append("N/A")
			elif 'year' in m and m['year']:
				subtitles.append(str(m['year']))
			else:
				subtitles.append("N/A")
			# Poster
			poster_url = ""
			if row is not None and 'imdb_id' in row and pd.notna(row['imdb_id']):
				poster_url = get_movie_poster(row['imdb_id'])
			elif imdb_id:
				poster_url = get_movie_poster(imdb_id)
			if poster_url and poster_url != "N/A":
				posters.append(poster_url)
			else:
				posters.append("/assets/owl.png")
			# Info
			if row is not None and 'imdb_id' in row and pd.notna(row['imdb_id']):
				infos.append(f"https://www.imdb.com/title/{row['imdb_id']}/")
			elif imdb_id:
				infos.append(f"https://www.imdb.com/title/{imdb_id}/")
			else:
				infos.append("N/A")
			# Trailer
			trailers.append(f"https://www.youtube.com/results?search_query={title.replace(' ', '+')}+trailer" if title != "N/A" else "N/A")

	else:
		return default_titles + default_titles + default_subtitles + default_posters + default_infos + default_trailers

	def pad(lst, fill, n=num_suggestions):
		return lst + [fill] * (n - len(lst))

	titles = pad(titles, "N/A")
	subtitles = pad(subtitles, "N/A")
	posters = pad(posters, "/assets/owl.png")
	infos = pad(infos, "N/A")
	trailers = pad(trailers, "N/A")

	return titles + titles + subtitles + posters + infos + trailers

clientside_callback(
	"""
	(switchOn) => {
	   document.documentElement.setAttribute("data-bs-theme", switchOn ? "light" : "dark");
	   return window.dash_clientside.no_update
	}
	""",
	Output("switch", "id"),
	Input("switch", "value"),
)

@app.callback(
	Output("navbar", "color"),  
	Output("navbar", "dark"),  
	Input("switch", "value")  
)
def update_navbar_color(color_mode):
	if color_mode == False: 
		return "dark", True
	else:
		return "light", False
	
if __name__ == '__main__':
	app.run(debug=True)
