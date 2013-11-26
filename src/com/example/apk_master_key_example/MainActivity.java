package com.example.apk_master_key_example;

import com.example.apk_master_key_example.R;

import java.util.ArrayList;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;

public class MainActivity extends Activity {
	
	private ArrayList<String> list_items = new ArrayList<String>();
	private ArrayAdapter<String> list_adapter;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		ListView list_view = (ListView)findViewById(R.id.listView1);
		list_adapter = new ArrayAdapter<String>(
			this, android.R.layout.simple_list_item_1, list_items);
		list_view.setAdapter(list_adapter);
		
		Button button_action = (Button)findViewById(R.id.button1);
		button_action.setOnClickListener(new Button.OnClickListener() {
			@Override
			public void onClick(View v) {
				long item_id = list_items.size();
				list_items.add(getString(R.string.item_text) + " " + String.valueOf(item_id));
				list_adapter.notifyDataSetChanged();
				return;				
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}
