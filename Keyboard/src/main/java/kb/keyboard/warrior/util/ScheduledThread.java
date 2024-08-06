package kb.keyboard.warrior.util;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO2;
import kb.keyboard.warrior.dto.StockDTO;

import java.io.IOException;
import java.net.SocketTimeoutException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dao.ExchangeRateDao;

@Component
public class ScheduledThread {

	String exchangeRateUpdateTime;

	@Autowired
	public SqlSession sqlSession;

	@Scheduled(fixedRate = 3600000) // 얘는 1시간에 한 번씩 돌아감.
	public void autoCrawler() {
		// 자동으로 돌아가게 할 거 여기다가 넣으면 됨.
		System.out.println("안녕 안녕~~");
	}

	@Scheduled(fixedRate = 600000) // 1분에 한 번
	public void fetchExchangeRates() {
		long startTime = System.currentTimeMillis(); // 시작 시간 기록
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		System.out.println("환율 자동 크롤링 스레드 동작 ");
		try {
			Document doc = Jsoup.connect("https://obank.kbstar.com/quics?page=C101423#CP").get();
			Elements rows = doc.select("table.tType01 tbody tr");
			for (Element row : rows) {
				ExchangeRateDTO rate = new ExchangeRateDTO();
				rate.setCurrencyCode(row.select("td:eq(0) a").text());
				rate.setCurrencyName(row.select("td:eq(1)").text());
				rate.setStandardRate(parseDouble(row.select("td:eq(2)").text()));
				rate.setTransferSend(parseDouble(row.select("td:eq(3)").text()));
				rate.setTransferReceive(parseDouble(row.select("td:eq(4)").text()));
				rate.setCashBuy(parseDouble(row.select("td:eq(5)").text()));
				rate.setCashSell(parseDouble(row.select("td:eq(6)").text()));
				rate.setUsdRate(parseDouble(row.select("td:eq(7)").text()));
				rate.setRateChangeLink(row.select("td:eq(8) a").attr("href"));

				dao.updateExchangeRate(rate);

			}
        } catch (HttpStatusException e) {
            System.err.println("HTTP error fetching URL. Status: " + e.getStatusCode());
        } catch (SocketTimeoutException e) {
            System.err.println("Connection timed out. Please try again later.");
        } catch (IOException e) {
            System.err.println("IOException occurred: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("An unexpected error occurred: " + e.getMessage());
        }
		long endTime = System.currentTimeMillis(); // 완료 시간 기록
		long duration = endTime - startTime; // 실행 시간 계산
		System.out.println("환율 자동 크롤링 실행  소요 시간: " + duration + "밀리초");
	}

	private Double parseDouble(String value) {
		try {
			return Double.parseDouble(value.replace(",", ""));
		} catch (NumberFormatException e) {
			return 0.0; // 기본값 설정 또는 다른 로직으로 변경 가능
		}
	}

	@Scheduled(fixedRate = 3600000) // 얘는 1시간에 한 번씩 돌아감.
	public void fetchMorRates() {
		long startTime = System.currentTimeMillis(); // 시작 시간 기록
		final String URL = "https://obank.kbstar.com/quics?page=C019205"; // 예시 URL
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		try {
			Document doc = Jsoup.connect(URL).get();
			Elements rows = doc.select(".tType01 tbody tr"); // 테이블 데이터 선택

			for (Element row : rows) {
				String rateType = row.select("th").text();
				String previousWeekRate = row.select("td").get(0).text();
				String currentWeekRate = row.select("td").get(1).text();
				String change = row.select("td").get(2).text();

				MorCoffixDTO morDTO = new MorCoffixDTO(rateType, previousWeekRate, currentWeekRate, change);

				dao.updateMor(morDTO);
			}
        } catch (HttpStatusException e) {
            System.err.println("HTTP error fetching URL. Status: " + e.getStatusCode());
        } catch (SocketTimeoutException e) {
            System.err.println("Connection timed out. Please try again later.");
        } catch (IOException e) {
            System.err.println("IOException occurred: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("An unexpected error occurred: " + e.getMessage());
        }
		long endTime = System.currentTimeMillis(); // 완료 시간 기록
		long duration = endTime - startTime; // 실행 시간 계산
		System.out.println("mor 금리 자동 크롤링 실행  소요 시간: " + duration + "밀리초");
	}

	@Scheduled(fixedRate = 3600000) // 1시간 마다
	public void fetchCofixRates() {
		long startTime = System.currentTimeMillis(); // 시작 시간 기록
		final String URL = "https://obank.kbstar.com/quics?page=C019206";
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		try {
			Document doc = Jsoup.connect(URL).get();
			Elements rows = doc.select(".tType01 tbody tr"); // 테이블 데이터 선택

			for (Element row : rows) {
				String rateType = row.select("th").text();
				String previousWeekRate = row.select("td").get(0).text();
				String currentWeekRate = row.select("td").get(1).text();
				String change = row.select("td").get(2).text();

				MorCoffixDTO morDTO = new MorCoffixDTO(rateType, previousWeekRate, currentWeekRate, change);
				dao.updateCofix(morDTO);
			}
        } catch (HttpStatusException e) {
            System.err.println("HTTP error fetching URL. Status: " + e.getStatusCode());
        } catch (SocketTimeoutException e) {
            System.err.println("Connection timed out. Please try again later.");
        } catch (IOException e) {
            System.err.println("IOException occurred: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("An unexpected error occurred: " + e.getMessage());
        }
		long endTime = System.currentTimeMillis(); // 완료 시간 기록
		long duration = endTime - startTime; // 실행 시간 계산
		System.out.println("cofix 금리 자동 크롤링 실행  소요 시간: " + duration + "밀리초");
	}

	// 한국 증시 크롤링
	@Scheduled(fixedRate = 600000) // 1분 마다
	public void fetchIndexData() {
		long startTime = System.currentTimeMillis(); // 시작 시간 기록
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		String[] urls = { "https://finance.naver.com/sise/sise_index.naver?code=KOSPI",
				"https://finance.naver.com/sise/sise_index.naver?code=KOSDAQ" };

		for (String url : urls) {
			try {
				Document doc = Jsoup.connect(url).get();

				String indexName = doc.selectFirst(".sub_tlt").text();
				Element kospiIndex = doc.selectFirst("#now_value");
				String kospiValue = kospiIndex.text();
				String changeValue = "";
				String changeRate = "";

				Element kospiIndexChange = doc.selectFirst("#change_value_and_rate");

				Element weekHighElement = doc.select(".table_kos_index tr:contains(52주최고) td.td").first();
				Element weekLowElement = doc.select(".table_kos_index tr:contains(52주최저) td.td2").first();

				String weekHighValue = weekHighElement.text();
				String weekLowValue = weekLowElement.text();

				if (kospiIndexChange != null) {
					changeValue = kospiIndexChange.select("span").first().text().split(" ")[0];
					changeRate = kospiIndexChange.ownText().trim();
				}

				double currentPriceValue = Double.parseDouble(kospiValue.replace(",", ""));
				double priceChangeValue = Double.parseDouble(changeValue.replace(",", ""));
				double changePercentageValue = Double.parseDouble(changeRate.replace("%", "").trim());
				double weekHigh52 = Double.parseDouble(weekHighValue.replace(",", ""));
				double weekLow52 = Double.parseDouble(weekLowValue.replace(",", ""));

				StockDTO stockDTO = new StockDTO();
				stockDTO.setCountry("한국");
				stockDTO.setIndexName(indexName);
				stockDTO.setCurrentPrice(currentPriceValue);
				stockDTO.setPriceChange(priceChangeValue);
				stockDTO.setChangePercentage(changePercentageValue);
				stockDTO.setWeekHigh52(weekHigh52);
				stockDTO.setWeekLow52(weekLow52);

				dao.updateStock(stockDTO);

	        } catch (HttpStatusException e) {
	            System.err.println("HTTP error fetching URL. Status: " + e.getStatusCode());
	        } catch (SocketTimeoutException e) {
	            System.err.println("Connection timed out. Please try again later.");
	        } catch (IOException e) {
	            System.err.println("IOException occurred: " + e.getMessage());
	        } catch (Exception e) {
	            System.err.println("An unexpected error occurred: " + e.getMessage());
	        }
		}
		long endTime = System.currentTimeMillis(); // 완료 시간 기록
		long duration = endTime - startTime; // 실행 시간 계산
		System.out.println("한국 증시 자동 크롤링 실행  소요 시간: " + duration + "밀리초");
	}

	@Scheduled(fixedRate = 600000) // 1분 마다
	// 외국 증시 크롤링
	public void fetchInterStockData() {
		long startTime = System.currentTimeMillis(); // 시작 시간 기록
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		String[] urls = { "https://finance.naver.com/world/sise.naver?symbol=DJI@DJI",
				"https://finance.naver.com/world/sise.naver?symbol=DJI@DJT",
				"https://finance.naver.com/world/sise.naver?symbol=NAS@IXIC",
				"https://finance.naver.com/world/sise.naver?symbol=NAS@NDX",
				"https://finance.naver.com/world/sise.naver?symbol=SPI@SPX",
				"https://finance.naver.com/world/sise.naver?symbol=NAS@SOX",
				"https://finance.naver.com/world/sise.naver?symbol=BRI@BVSP",
				"https://finance.naver.com/world/sise.naver?symbol=SHS@000001",
				"https://finance.naver.com/world/sise.naver?symbol=SHS@000002",
				"https://finance.naver.com/world/sise.naver?symbol=SHS@000003",
				"https://finance.naver.com/world/sise.naver?symbol=NII@NI225",
				"https://finance.naver.com/world/sise.naver?symbol=HSI@HSI",
				"https://finance.naver.com/world/sise.naver?symbol=HSI@HSCE",
				"https://finance.naver.com/world/sise.naver?symbol=HSI@HSCC",
				"https://finance.naver.com/world/sise.naver?symbol=TWS@TI01",
				"https://finance.naver.com/world/sise.naver?symbol=INI@BSE30",
				"https://finance.naver.com/world/sise.naver?symbol=MYI@KLSE",
				"https://finance.naver.com/world/sise.naver?symbol=IDI@JKSE",
				"https://finance.naver.com/world/sise.naver?symbol=LNS@FTSE100",
				"https://finance.naver.com/world/sise.naver?symbol=PAS@CAC40",
				"https://finance.naver.com/world/sise.naver?symbol=XTR@DAX30",
				"https://finance.naver.com/world/sise.naver?symbol=STX@SX5E",
				"https://finance.naver.com/world/sise.naver?symbol=RUI@RTSI",
				"https://finance.naver.com/world/sise.naver?symbol=ITI@FTSEMIB" };

		for (String url : urls) {
			try {
				Document doc = Jsoup.connect(url).get();

				// Index name 가져오기
				Element countryElement = doc.selectFirst(".h_area .state");
				String country = countryElement != null ? countryElement.text() : "Unknown Index";

				Element indexNameElement = doc.selectFirst(".h_area h2");
				String indexName = indexNameElement != null ? indexNameElement.text() : "Unknown Index";

				// 현재 지수 가져오기
				Element todayElement = doc.selectFirst(".no_today");
				String currentPrice = extractNumberFromElement(todayElement);

				// 변동폭 및 변동률 가져오기
				Element exdayElement = doc.selectFirst(".no_exday");
				String priceChange = "";
				String changePercentage = "";

				// 52주 최고/최저 비교
				Element weekHighElement = doc.selectFirst(".no_info td:contains(52주 최고) em");
				Element weekLowElement = doc.selectFirst(".no_info td:contains(52주 최저) em");

				String weekHigh52 = extractNumberFromElement(weekHighElement);
				String weekLow52 = extractNumberFromElement(weekLowElement);

				if (exdayElement != null) {
					Element changeValueElement = exdayElement.selectFirst(".no_down, .no_up");
					priceChange = extractNumberFromElement(changeValueElement);

					List<Element> changeRateElements = exdayElement.select("em.no_down, em.no_up");
					if (changeRateElements.size() > 1) {
						Element changeRateElement = changeRateElements.get(1);
						changePercentage = extractNumberFromElement(changeRateElement).replace("+", "").replace("%", "")
								.replace("(", "").replace(")", "").trim();
					}
				}

				// 기본값 설정 및 값이 비어 있을 경우 대비
				double currentPriceValue = currentPrice.isEmpty() ? 0.0
						: Double.parseDouble(currentPrice.replace(",", ""));
				double priceChangeValue = priceChange.isEmpty() ? 0.0
						: Double.parseDouble(priceChange.replace(",", ""));
				double changePercentageValue = changePercentage.isEmpty() ? 0.0 : Double.parseDouble(changePercentage);
				double weekHigh52Value = weekHigh52.isEmpty() ? 0.0 : Double.parseDouble(weekHigh52.replace(",", ""));
				double weekLow52Value = weekLow52.isEmpty() ? 0.0 : Double.parseDouble(weekLow52.replace(",", ""));

				// changePercentage가 음수인 경우 priceChange도 음수로 설정
				if (changePercentageValue < 0) {
					priceChangeValue = -Math.abs(priceChangeValue);
				}

				// DTO에 값 설정
				StockDTO stockDTO = new StockDTO();
				stockDTO.setCountry(country);
				stockDTO.setIndexName(indexName);
				stockDTO.setCurrentPrice(currentPriceValue);
				stockDTO.setPriceChange(priceChangeValue);
				stockDTO.setChangePercentage(changePercentageValue);
				stockDTO.setWeekHigh52(weekHigh52Value);
				stockDTO.setWeekLow52(weekLow52Value);

				dao.updateStock(stockDTO);

	        } catch (HttpStatusException e) {
	            System.err.println("HTTP error fetching URL. Status: " + e.getStatusCode());
	        } catch (SocketTimeoutException e) {
	            System.err.println("Connection timed out. Please try again later.");
	        } catch (IOException e) {
	            System.err.println("IOException occurred: " + e.getMessage());
	        }  catch (NumberFormatException e) {
				System.err.println("Number format exception occurred for URL: " + url);
				e.printStackTrace();
			}catch (Exception e) {
	            System.err.println("An unexpected error occurred: " + e.getMessage());
			}
		}
		long endTime = System.currentTimeMillis(); // 완료 시간 기록
		long duration = endTime - startTime; // 실행 시간 계산
		System.out.println("외국 증시 자동 크롤링 실행  소요 시간: " + duration + "밀리초");
	}

	private String extractNumberFromElement(Element element) {
		StringBuilder number = new StringBuilder();
		if (element != null) {
			for (Element span : element.select("span")) {
				number.append(span.text());
			}
		}
		return number.toString();
	}

	@Scheduled(fixedRate = 36000000)
	public void fetchsuperRates() {
		long startTime = System.currentTimeMillis(); // 시작 시간 기록
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		String URL = "https://obank.kbstar.com/quics?page=C030266&cc=b028364:b049008&%EB%B8%8C%EB%9E%9C%EB%93%9C%EC%83%81%ED%92%88%EC%BD%94%EB%93%9C=DP01000029&%EB%85%B8%EB%93%9C%EC%BD%94%EB%93%9C=00007&%ED%8C%90%EB%A7%A4%EC%97%AC%EB%B6%80=1&QSL=F#none";
		try {
			Document doc = Jsoup.connect(URL).get();
			Elements rows = doc.select("table.tablestyle-01.mgt2 tr");

			for (Element row : rows) {
				if (row.select("td").size() > 0) {
					String period = row.select("td").get(0).text();
					String fixedRate = row.select("td").get(1).text();
					String monthlyInterestRate = row.select("td").get(2).text();
					String compoundMonthlyRate = row.select("td").get(3).text();
					SoosinRateDTO data = new SoosinRateDTO(period, fixedRate, monthlyInterestRate, compoundMonthlyRate);
					dao.updateInterestRate(data);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		long endTime = System.currentTimeMillis(); // 완료 시간 기록
		long duration = endTime - startTime; // 실행 시간 계산
		System.out.println("국민수퍼정기예금 크롤링 실행  소요 시간: " + duration + "밀리초");
	}

	@Scheduled(fixedRate = 36000000)
	public void fetchSoosinRates() {
		long startTime = System.currentTimeMillis(); // 시작 시간 기록
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		String URL = "https://obank.kbstar.com/quics?page=C030266&cc=b028364:b049008&%EB%B8%8C%EB%9E%9C%EB%93%9C%EC%83%81%ED%92%88%EC%BD%94%EB%93%9C=DP01000938&%EB%85%B8%EB%93%9C%EC%BD%94%EB%93%9C=00007&%ED%8C%90%EB%A7%A4%EC%97%AC%EB%B6%80=1&QSL=F#none";
		try {
			Document doc = Jsoup.connect(URL).get();
			Elements rows = doc.select("#ptabMenu2 .n_ptType1 tbody tr");

			for (Element row : rows) {
				Elements cols = row.select("td");
				if (!cols.isEmpty()) {
					String period = cols.get(0).text();
					double basicRate = parseDouble(cols.get(1).text());
					double customerRate = parseDouble(cols.get(2).text());
					dao.updateInterestRate2(new SoosinRateDTO2(period, basicRate, customerRate));
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		long endTime = System.currentTimeMillis(); // 완료 시간 기록
		long duration = endTime - startTime; // 실행 시간 계산
		System.out.println("Star 정기예금 크롤링 실행  소요 시간: " + duration + "밀리초");
	}

}
